class Connection < ActiveRecord::Base
  
  belongs_to :to_node, :class_name => "Node"
  belongs_to :from_node, :class_name => "Node"
  
end
