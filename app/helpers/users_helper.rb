module UsersHelper
  # handles the name url
  def name_link(string,url)
    if url == ''
      return string
    else
      return link_to string, url
    end
  end
end
