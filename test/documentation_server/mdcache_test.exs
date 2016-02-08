defmodule DocumentationServer.Mdcache do
   use ExUnit.Case, async: true

   setup do
      {:ok, cache} = DocumentationServer.Mdcache.start_link "test_files/root"
      {:ok, cache: cache}
   end

   test "caches all md files" do
      assert length(DocumentationServer.Mdcache.find_all) == 5
   end

end
