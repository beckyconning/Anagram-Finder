class Dictionary < ActiveRecord::Base
  
  belongs_to :root, :class_name => "Node", :foreign_key => "root_node_id", :dependent => :destroy
  
  before_create {|dictionary| dictionary.create_root}

  def anagrams_of(word)
    start_time = Time.now
    permutations = word.split("").permutation.to_a

    joined_permutations = permutations.collect { |permutation| 
      permutation.join("")
    }

    anagrams = joined_permutations.select { |joined_permutation| 
      self.contains_word(joined_permutation)
    }

    puts Time.now - start_time

    return anagrams
  end

  def build_from_file(file_path = "public/dictionary.txt")
    start_time = Time.now
    file = File.new(file_path, "r")
    while (line = file.gets)
    	self.insert(line.gsub(/\n/,""))
    end
    file.close
    return Time.now - start_time
  end

  def contains_word(word)
    if (find_result = self.find(word)[word]) then
      if (find_result[:color] == true) then
        return true
      end
    end
    return false
  end
  
  #private
  
  def insert(string) 
    find_results = self.find(string)
    unless (find_results[string]) then
      found_string = find_results.keys.first
      node = find_results.values.first
      remaining_string = string[found_string.length..-1]
      node.children.each { |child|
        prefix = child.common_prefix_with(remaining_string)
        unless (prefix == nil || prefix.empty?)
          child.split_by_prefix(prefix, remaining_string)
          node = child
          remaining_string = remaining_string[prefix.length..-1]
          break  
        end
      }
      unless (remaining_string.empty?)
        node.children.create(:key=> remaining_string, :color => true)
      end
    end
    return string
  end
    
  def find(string) 
    node = self.root
    key = String.new
    found_string = String.new
    string.each_char.with_index { |character, index|
      key = key + character
      if (possible_node = node.children.find_by_key(key)) then
        node = possible_node
        found_string = found_string + key
        key = String.new
      elsif (node.children.empty?) then
        return found_string=>node 
      end
    }
    return found_string=>node 
  end

  
end
