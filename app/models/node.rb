# i tried using a patricia tree to solve the problem, but in most cases it was slower
# than a canonical hash :( i learnt allot about data structures though :P
#
#class Node
#    
#  attr_accessor :key, :is_leaf, :children
#
#  def initialize(params = {})
#    @key = params[:key] ? params[:key] : ""
#    @is_leaf = params[:is_leaf] ? params[:is_leaf] : false
#    @children = params[:children] ? params[:chidlren] : []
#    @dictionary_id = params[:dictionary_id] ? params[:dictionary_id] : nil
#  end
#  
#  def common_prefix_length(string)
#    result = 0
#    if (string && self.key) then
#      while (result < string.length && result < self.key.length) do
#        break if string[result].chr != self.key[result].chr
#        result = result + 1
#      end
#    end
#    return result
#  end
#  
#  def split_at_prefix_length(common_prefix_length)
#    common_prefix = self.key[0 .. common_prefix_length - 1]
#    uncommon_suffix = self.key[common_prefix_length .. -1]
#    split_node = Node.new(:key => uncommon_suffix, :is_leaf => self.is_leaf)
#    split_node.children.concat(self.children)
#    self.key = common_prefix
#    self.is_leaf = false
#    self.children.clear
#    self.children << split_node
#    return self
#  end
#  
#  def lookup(string) 
#    node = self
#    key = String.new
#    found_string = String.new
#    string.each_char.with_index { |character, index|
#      key = key + character
#      if (node.children == []) then
#        return found_string=>node
#      else
#        child_with_matching_prefix = nil
#        node.children.each { |child| 
#          if (child.key == key)
#            child_with_matching_prefix = child
#          end
#        }
#        if (child_with_matching_prefix != nil)
#          node = child_with_matching_prefix
#          found_string = found_string + key
#          key = String.new
#        end
#      end
#    }
#    return found_string=>node
#  end
#  
#  def insert(key)
#    depth = 0
#    lookup_result = self.lookup(key)
#    found_key = lookup_result.keys.first
#    node = lookup_result.values.first
#    remaining_key = key[found_key.length..-1]
#    node.children.each { |child|
#      common_prefix_length = child.common_prefix_length(remaining_key)
#      if (common_prefix_length > 0) then  
#        node = child.split_at_prefix_length(common_prefix_length)
#        depth = depth + 1
#        if (common_prefix_length >= remaining_key.length) then
#          node.is_leaf = true
#        end
#        remaining_key = remaining_key[common_prefix_length..-1]
#        break
#      end
#    }  
#    node.children << Node.new(:key => remaining_key, :is_leaf => true)
#    return key
#  end
#  
#  def insert_leaves_from_file(file_path)
#    file = File.new(file_path, "r")
#    while (line = file.gets)
#      self.insert(line.chomp) if line != ""
#    end
#    file.close
#    return self
#  end
#  
#  def contains(word)
#    
#    lookup_result = self.lookup(word)
#    found_string = lookup_result.keys.first
#    found_node = lookup_result.values.first
#    if (found_string == word && found_node.is_leaf)
#      return true
#    else
#      return false
#    end
#  end
#  
#  def anagrams_for(word)
#    anagrams = []
#    word.split("").permutation.each { |perm|
#      joined_perm = perm.join
#      if (self.contains(joined_perm)) then
#        anagrams << joined_perm
#      end
#    }
#    return anagrams
#  end
#  
#  def save_for_session(session)
#    NodeCache.add_node_for_session(self, session)
#  end
#
#end