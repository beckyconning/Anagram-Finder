# A simple multi-value hash with ordered keys :)
class CanonicalHash
  
  def initialize
    @hash = Hash.new
  end
  
  def [](string)
    return @hash[string]
  end
  
  def []=(key, value)
    @hash[key] = value
  end
  
  # if there is already pair with a key of the given sorted value then assume the value
  # is an array and add the given value to it
  def <<(string)
    canonicalized_string = canonicalize_string(string)
    if self[canonicalized_string]
      @hash[canonicalized_string] << string
    else
      self[canonicalized_string] = [string]
    end
  end
  
  # open the file at a given path and add each line to the hash
  def insert_strings_from_file(file_path)
    file = File.new(file_path, "r")
    while (line = file.gets)
      self << line.chomp if line != ""
    end
    file.close
    return self
  end
  
  # return the value of the pair with the given string alphabetically as a key
  def anagrams_for(string)
    canonicalized_string = canonicalize_string(string)
    if self[canonicalized_string]
      return self[canonicalized_string]
    else
      return Array.new
    end
  end
  
  # sort the given string alphabetically
  def canonicalize_string(string)
    canonicalized_string = string.downcase.split("").sort.join("")
  end

end
