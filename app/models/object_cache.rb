# rails doesn't clear class variables between requests.
# i decided to use one to persist dictionaries for as long 
# as the the ruby interpreter is open.

class ObjectCache
  # create a hash as a class variable
  @@objects = {}

  # given a session return an object from the hash
  def self.object_for_session(session)
    return @@objects[session]
  end
  
  # given an object and a session, persist them in the hash
  def self.set_object_for_session(object, session)
    @@objects[session] = object
    return @@objects[session]
  end
  
  # given a session destroy and return the associated pair
  def self.destroy_object_for_session(session)
    temp_object = @@objects[session]
    @@objects.delete(session)
    return temp_object
  end
  
end