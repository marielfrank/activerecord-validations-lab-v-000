class Post < ActiveRecord::Base
    validates :title, presence: true
    validates :content, length: {minimum: 250}
    validates :summary, length: {maximum: 250}
    validates  :category, inclusion: {in: %w(Fiction Non-Fiction)}
    validate :title_is_clickbaity

    def title_is_clickbaity
        clickbait = ["Won't Believe", "Secret", "Guess"]
        truthy = false
        if self.title && !self.title.scan(/Top\w[0-9]/).empty?
            truthy = true
        elsif self.title
            truthy = clickbait.any? do |bait|
                self.title.include?(bait)
            end
        end
        errors.add(:title, "must be clickbaity") unless truthy
    end
end
