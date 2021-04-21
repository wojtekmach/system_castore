defmodule SystemCAStoreTest do
  use ExUnit.Case, async: true

  test "it works" do
    pem = File.read!(SystemCAStore.file_path())
    certs = :public_key.pem_decode(pem)
    assert length(certs) > 0

    File.rm!(SystemCAStore.file_path())
    assert File.exists?(SystemCAStore.file_path())
  end
end
