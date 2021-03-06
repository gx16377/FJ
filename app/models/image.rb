class Image < ActiveRecord::Base
	has_many :candidates
	has_many :votes
	has_many :admins, :through => :votes

	def previous
      Image.where(" id < ?",  self.id).where("flag = ?", false).last
    end
  
    def next
      Image.where(" id > ?",  self.id).where("flag = ?", false).first
    end
    
    # def get_context
    # 	#
    # end

    def decided?
      self.flag
    end

    #get the final result
    def result 
       self.candidates.order("candidates.votesum DESC").first.content
    end

    #update image status
    def update_status
      sum=self.candidates.sum(:votesum)
      result= ((5*sum) >= (4*(Admin.count)))
      self.flag=result
      self.save 
    end

end
