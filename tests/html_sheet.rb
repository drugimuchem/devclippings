require 'pp'

module HtmlSheet

  def self.to_html(sheetStr)
    sheetHtml = []
    hStates   = {}
    (2..4).each{|i| hStates[i] = 0}

    sheetStr.each_line do |line|
      line.chomp!
      if line =~ /^\s*{#+}.+/
        hParts  = line.lstrip.split('}',2)
        hText   = hParts[1].strip
        hLevel  = hParts[0].length
        hStates[hLevel]+=1

        # this is a new chapter on level N, reset all N+ levels to zero
        hStates.each{|k,v| hStates[k] = 0 if k>hLevel }

        hNumber = hStates.keys.grep(1..hLevel).collect{|k| hStates[k]}.join('.')

        line = '<h%d id="%s-%s">%s</h%d>' % [ hLevel, hNumber, to_slug(hText), hText, hLevel ]
      else
        line = '<p>%s</p>' % line
      end

      sheetHtml.push(line)
    end

    sheetHtml.join
  end
 
  def self.to_slug(headingStr)
    headingStr.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
end
