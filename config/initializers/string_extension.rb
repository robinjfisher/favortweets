class String
  
  def clean_up
    tags = self.split(" ")
    tags.each do |t|
      t.strip!
      t.downcase!
      t.gsub!(/\W/,"")
    end
    tags.join(" ")
  end
  
end