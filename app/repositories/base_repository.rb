class BaseRepository
  def initialize(csv_file_path)
    @csv_file = csv_file_path
    @elements = []
    load_csv if File.exist?(@csv_file)
    @next_id = @elements.empty? ? 1 : @elements.last.id + 1
  end

  def all
    @elements
  end

  def create(element)
    element.id = @next_id
    @elements << element
    @next_id += 1
    save_csv
  end

  def find(id)
    @elements[id - 1]
  end
end