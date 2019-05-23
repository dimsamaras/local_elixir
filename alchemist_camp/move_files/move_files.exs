matcher = ~r/\.(jpg|jpeg|gif|png|bmp)$/

matched_files = File.ls!() |> Enum.filter(&Regex.match?(matcher, &1))

num_matched = Enum.count(matched_files)

msg_end =
  case num_matched do
    1 -> "file"
    _ -> "files"
  end

IO.puts("Matched #{num_matched} #{msg_end}")

if !File.exists?("./images") do
  IO.puts("images dir does not exist. Creating...")

  case File.mkdir("./images") do
    :ok -> IO.puts("./images directory created")
    {:error, reason} -> IO.puts("#{:file.format_error(reason)}")
  end
end

Enum.each(matched_files, fn filename ->
  case File.rename(filename, "./images/#{filename}") do
    :ok -> IO.puts("#{filename} successfully moved to images directory")
    {:error, reason} -> IO.puts("#{:file.format_error(reason)}")
  end
end)
