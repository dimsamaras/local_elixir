defmodule MinimalTodo do
    def start do
        input = IO.gets("Would you like to create a new csv? (y/n)\n") 
        |> String.trim 
        |> String.downcase
        if input == "y" do
            create_initial_todo |> get_command
        else
            load_csv()
        end
    end

    def validate(filename) do
        [name | extension] = String.split(filename, ".")
        if Enum.at(extension, -1) !== "csv" do
            IO.puts ~s(Only files with ".csv" extension allowed!\n)
            start()
        else
            read(filename)   
        end        
    end

    def get_command(data) do
        prompt = """
        Type the first letter of the command you want to execute
        R)ead TODOs    A)dd a TODO    D)elete a TODO    L)load a file   S)ave a file   Q)uit todo manager
        """

        command = IO.gets(prompt)
            |> String.trim
            |> String.downcase

        case command do
            "a" -> add_todo(data)
            "d" -> delete_todo(data)        
            "q" -> "Bye!"
            "r" -> show_todos(data)
            "s" -> save_csv(data)
            _   -> get_command(data)
        end
    end

    def read(filename) do
        case File.read(filename) do
            {:ok, body}      -> body
            {:error, reason} -> IO.puts ~s(Could not open file "#{filename}"\n)
                                IO.puts ~s("#{:file.format_error reason}"\n)
                                start()
                
        end
    end

    def parse(text) do
        [header | lines] = String.split(text, ~r{(\r|\n|\r\n)})  
        titles = tl String.split(header, ",")
        parse_lines(lines, titles)
    end

    def parse_lines(lines, titles) do
        Enum.reduce(lines, %{}, fn line, built ->
            [name | fields] = String.split(line, ",")
            if Enum.count(fields) == Enum.count(titles) do
                line_data = Enum.zip(titles, fields) |> Enum.into(%{})
                Map.merge(built, %{name =>line_data})    
            else
                built
            end    
        end)
    end

    def show_todos(data, next_command? \\ true) do
        items = Map.keys(data)
        IO.puts "You have the following Todos:\n"
        Enum.each items, fn item -> IO.puts item end
        IO.puts "\n"
        if next_command? do 
            get_command(data)      
        end    
    end

    def delete_todo(data) do
        todo = IO.gets("Which TODO to delete?\n") |> String.trim
        if Map.has_key?(data, todo) do
            IO.puts "Ok."
            new = Map.drop(data, [todo])
            IO.puts ~s("#{todo}" has been deleted!)
            get_command(new)
        else
            IO.puts ~s("#{todo}" not found!)%{name => Enum.into(fields, %{})}
            show_todos(data, false)
            delete_todo(data)
        end
    end

    def add_todo(data) do
        name = get_item_name(data)
        titles = get_fields(data)
        fields = Enum.map(titles, fn field->
            field_from_user(field)
            end
        )
        new_todo = %{name => Enum.into(fields,%{})}
        IO.puts ~s(new todo "#{name}" added.)
        new_data = Map.merge(data, new_todo)
        get_command(new_data)
    end

    def load_csv() do
        filename = IO.gets("Name of .csv to load:") |> String.trim
        validate(filename)
        get_command(read(filename) |> parse())
    end

    def save_csv(data) do
        filename = IO.gets("Name of .scv to save: \n") |> String.trim
        filedata = prepare_csv(data)
        case File.write(filename, filedata) do
            :ok              -> IO.puts "File saved."
                                get_command(data)
            {:error, reason} -> IO.puts ~s(Could not save "#{filename}")
                                IO.puts ~s("{:file.format_error reason}"\n)

        end
    end

    def prepare_csv(data) do
        headers = ["Item" | get_fields(data)]
        items  = Map.keys(data)
        item_rows = Enum.map(items, fn item ->
            [item | Map.values(data[item])]
            end
        )
        rows = [headers | item_rows]
        row_strings = Enum.map(rows, &(Enum.join(&1, ",")))
        Enum.join(row_strings, "\n")

    end

    def get_item_name(data) do
        name = IO.gets("Enter the name for the new todo: ") |> String.trim
        if name do
            if Map.has_key?(data, name) do
            IO.puts("Todo with given name already exists! Try another! \n")
            get_item_name(data)
            else
                name
            end  
        else
            get_item_name(data)
        end 
              
    end

    def get_fields(data) do
        data[hd Map.keys data] |> Map.keys
    end

    def field_from_user(name) do
        field = IO.gets("#{name}: ") |> String.trim
        case field do
            _ -> {name, field}
        end
    end

    def create_header(headers) do
        case IO.gets("Add field: ") |> String.trim do
            ""      -> headers
            header  -> create_header([header | headers])     
        end
    end

    def create_headers() do
        IO.puts "What data should each Todo have?\n"
        <> "Enter field names one by one and an empty line and you are done!\n"
        <> "Skip 'item' as it wil be asked afterwards.\n"

        create_header([])        

    end

    def create_initial_todo() do
        titles = create_headers()
        name = get_item_name(%{})
        fields = Enum.map(titles, &(field_from_user(&1)))      
        IO.puts ~s(New todo "#{name}" added)
        %{name => Enum.into(fields, %{})}
    end

end