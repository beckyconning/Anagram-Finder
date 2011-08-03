class Node < ActiveRecord::Base
  
  has_many :dictionaries
  has_many :child_connections, :class_name => 'Connection', :foreign_key => 'from_node_id', :dependent => :destroy
  has_many :parent_connections, :class_name => 'Connection', :foreign_key => 'to_node_id'
  has_many :children, :through => :child_connections, :source => :to_node, :dependent => :destroy
  has_many :parents, :through => :parent_connections, :source => :from_node
  
  def split_by_prefix(prefix, remaining_string)
    #puts "splitting " + self.key + " by " + prefix
    if (prefix != nil)
      split_node = Node.new(:key => self.key, :color => self.color)
      self[:key] = prefix
      if (prefix == remaining_string) then
        self[:color] = true
      else
        self[:color] = false
      end
      split_node[:key] = split_node[:key].to_s[prefix.length..-1]
      self.children << split_node
      self.save
    end
    return false
  end
  
  def common_prefix_with(string)
    #puts "finding common prefix for " + self.key + " and " + string
    if (string != nil && self.key != nil) then
      prefix = String.new
      string.each_char.with_index { |character, index|
        break if (index > prefix.length)
        if (character == self.key.split("")[index]) then
          prefix = prefix + character
        end
      }
    end
    return prefix
  end
end
