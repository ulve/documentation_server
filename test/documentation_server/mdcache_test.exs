defmodule DocumentationServer.MdcacheTest do
   use ExUnit.Case, async: true

   setup do
      {:ok, cache} = DocumentationServer.Mdcache.start_link "test/test_files/root"
      {:ok, cache: cache}
   end

   test "caches all md files" do
      {:reply, cache} = DocumentationServer.Mdcache.find_all
      assert length(cache) == 5
   end

   test "all md files have content" do
      {:reply, cache} = DocumentationServer.Mdcache.find_all
      assert Enum.all?(cache, fn({_, i})-> String.length(i) > 0 end)
   end

   test "reads content of file" do
      {:reply, cache} = DocumentationServer.Mdcache.find_all
      content = Enum.filter(cache, fn({x, _})-> String.contains?(x, "file5.md") end) |> List.first
      assert elem(content, 1) |> String.starts_with?("Content")
   end

   test "updates index" do
      {:reply, cache} = DocumentationServer.Mdcache.find_all

      File.write("test/test_files/root/TempFile.md", "New file")
      DocumentationServer.Mdcache.update_index
      File.rm("test/test_files/root/TempFile.md")
      
      {:reply, new_cache} = DocumentationServer.Mdcache.find_all

      assert length(cache) < length(new_cache)
   end
end
