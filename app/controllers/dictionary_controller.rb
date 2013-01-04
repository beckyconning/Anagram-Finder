class DictionaryController < ApplicationController
  session :on
  
  def index
    
  end
  
  def upload
    # get the uploaded dictionary file from the given parameters
    dictionary_file = params["file_form"]["file"]
    # create a new canonical hash and feed all the words from the given file
    dictionary = CanonicalHash.new.insert_strings_from_file(dictionary_file.tempfile.path)
    # persist the dictionary so that given the session we can get it again later
    ObjectCache.set_object_for_session(dictionary, session)
    # respond to javascript requests with the original filename of the dictionary file
    respond_to do |format|
      format.js { render :text => dictionary_file.original_filename }
    end
  end
  
  def anagrams
    # get the word from the given paraneters
    @word = params["anagram_form"]["word"]
    # get anagrams for the word from the dictionary for this session
    if ObjectCache.object_for_session(session)
      @dictionary_exists = true
      @anagrams = ObjectCache.object_for_session(session).anagrams_for(@word)
    else
      @dictionary_exists = false
    end
    # respond to javascript requests with the result rendered as html
    respond_to do |format|
      format.js { render :partial => "anagram_result" }
    end
  end
  
  def destroy
    # destroy the dictionary for this session and then the session itself
    ObjectCache.destroy_object_for_session(session)
    session :off
  end
  
  #def upload_dictionary
  #  dictionary_file = params["file_form"]["file"]
  #  dictionary_root_node = Node.new.insert_leaves_from_file(dictionary_file.tempfile.path)
  #  NodeCache.set_node_for_session(dictionary_root_node, session)
  #  respond_to do |format|
  #    format.js { render :text => dictionary_file.original_filename }
  #  end
  #end
  #
  #def anagrams
  #  @word = params["anagram_form"]["word"]
  #  @anagrams = NodeCache.node_for_session(session).anagrams_for(@word)
  #  respond_to do |format|
  #    format.js { render :partial => "anagram_result" }
  #  end
  #end
  #
  #def destroy
  #  NodeCache.destroy_node_for_session(session)
  #  session = nil
  #end
  
end
