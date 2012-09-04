module HtmlSheet

  def self.to_html(sheetStr)
    sheetHtml = []
    hStates   = {}
    txtBuffer = ''
    (2..4).each{|i| hStates[i] = 0}

    flushBuffer = lambda do
      if txtBuffer =~ /\S/
        sheetHtml.push('<div class="text">%s</div>' % txtBuffer.chomp) # remove last \n
      end
      txtBuffer.clear
    end

    sheetStr.each_line do |line|
        #line.chomp!
      if line =~ /^\s*{#+}.+/

        flushBuffer.call

        hParts  = line.lstrip.split('}',2)
        hText   = hParts[1].strip
        hLevel  = hParts[0].length
        hStates[hLevel]+=1

        # this is a new chapter on level N, reset all N+ levels to zero
        hStates.each{|k,v| hStates[k] = 0 if k>hLevel }

        hNumber = hStates.keys.grep(1..hLevel).collect{|k| hStates[k]}.join('.')

        line = '<h%d id="%s-%s">%s</h%d>' % [ hLevel, hNumber, to_slug(hText), hText, hLevel ]
        sheetHtml.push(line)
      elsif line =~ /\S/
        txtBuffer << line
      end
    end

    flushBuffer.call

    sheetHtml.join
  end
 
  def self.to_slug(headingStr)
    headingStr.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
end
