class String

    def slug
        itself.downcase.gsub(" ","-")
    end

end