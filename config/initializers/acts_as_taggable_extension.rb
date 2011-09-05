module ActsAsTaggableOn
  class Tag < ::ActiveRecord::Base
    
    def initial
      string = self.name
      string[0].chr
    end
    
  end
  
end