defmodule SystemCAStore do
  @moduledoc """
  Functions to access the system CA store.

  Currently only macOS is supported.
  """

  @system_root_keychain "/System/Library/Keychains/SystemRootCertificates.keychain"

  @doc """
  Returns the path to the CA certificate store PEM file.

  ## Examples

      SystemCAStore.file_path()
      #=> /Users/me/system_castore/_build/dev/lib/system_castore/priv/cacerts.pem"

  """
  def file_path() do
    if cached_path_mtime() < File.stat!(@system_root_keychain).mtime() do
      path = cached_path()
      pem = extract()
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

  defp extract() do
    case System.cmd("security", ~w(find-certificate -a -p #{@system_root_keychain})) do
      {pem, 0} ->
        pem

      other ->
        raise inspect(other)
    end
  end
end
