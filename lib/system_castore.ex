defmodule SystemCAStore do
  @moduledoc "README.md"
             |> File.read!()
             |> String.split("<!-- MDOC !-->")
             |> Enum.fetch!(1)

  @doc """
  Returns the path to the CA certificate store PEM file.
  """
  def file_path() do
    case :os.type() do
      {:unix, :darwin} ->
        macos_cached_file_path()

      {:unix, :linux} ->
        "/etc/ssl/certs/ca-certificates.crt"

      other ->
        raise ArgumentError, "OS not supported: #{inspect(other)}"
    end
  end

  @system_root_keychain "/System/Library/Keychains/SystemRootCertificates.keychain"

  defp macos_cached_file_path() do
    if cached_path_mtime() < File.stat!(@system_root_keychain).mtime() do
      path = cached_path()
      pem = macos_extract()
      File.mkdir_p!(Path.dirname(path))
      File.write!(path, pem)
      path
    else
      cached_path()
    end
  end

  defp cached_path_mtime() do
    case File.stat(cached_path()) do
      {:ok, stat} -> stat.mtime
      _ -> {{0, 0, 0}, {0, 0, 0}}
    end
  end

  defp cached_path() do
    Application.app_dir(:system_castore, "priv/cacerts.pem")
  end

  defp macos_extract() do
    case System.cmd("security", ~w(find-certificate -a -p #{@system_root_keychain})) do
      {pem, 0} ->
        pem

      other ->
        raise inspect(other)
    end
  end
end
