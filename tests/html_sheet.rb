require 'pp'

module HtmlSheet

  def five
    5
  end

  def to_html(sheetStr)
    sheetHtml = []
    hInc      = {}
    (2..4).each{|i| hInc[i] = 0}

    sheetStr.each_line do |line|
      line.chomp!
      if line =~ /^\s*{#+}.+/
        hParts  = line.lstrip.split('}',2)
        hText   = hParts[1].strip
        hLevel  = hParts[0].length
        hInc[hLevel]+=1

        # this is a new chapter on level N, reset all N+ levels to zero
        hInc.each{|k,v| hInc[k] = 0 if k>hLevel }

        hNumber = hInc.keys.grep(1..hLevel).collect{|k| hInc[k]}.join('.')

        line = '<h%d id="%s-%s">%s</h%d>' % [ hLevel, hNumber, to_slug(hText), hText, hLevel ]
      else
        line = '<p>%s</p>' % line
      end

      sheetHtml.push(line)
    end

    sheetHtml.join
  end
 
=begin

    content = {
      text     => 'hello' ,
      chapters => [
        {
          title    => 'First chapter',
          text     => 'content of chapter',
          chapters => []
        }
        
      ]
    }

=end

  def to_chapters(sheetStr)

    sheetHash = {
      :chapters => []
    }
    curr = sheetHash

    sheetStr.each_line do |line|

      print pp sheetHash

      if heading = line.match( /^\s*{#}(.+)$/ )

        chapter = { 
          :title => heading[1].strip,
        } 
        sheetHash[:chapters] = [] unless sheetHash.has_key? :chapters
        sheetHash[:chapters].push(chapter)
        curr = chapter

      elsif heading = line.match( /^\s*{##}(.+)$/ )
        
        subChapter = { 
          :title => heading[1].strip,
        } 
        chapter[:chapters] = [] unless chapter.has_key? :chapters
        chapter[:chapters].push(subChapter)
        curr = subChapter

      else
        curr[:text] = '' if curr[:text].nil?
        curr[:text] << line
      end
    end
    sheetHash
  end

  def to_slug(headingStr)
    headingStr.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
end
