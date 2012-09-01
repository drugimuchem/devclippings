require 'test/unit'
require './html_sheet.rb'

class StringTest < Test::Unit::TestCase
  include HtmlSheet

  def est_to_chapters_basic
    samples = [
      [ '', {} ],
      [ "Deep dive", { :text => 'Deep dive' } ],
      [ "Deep\ndive", { :text => "Deep\ndive" } ],
    ]
    assert_to_chapters_in_out(samples)
  end

  def test_to_html_basic
    samples = [
      [ '', '' ],
      [ "Deep dive", "<p>Deep dive</p>" ],
      [ "Deep\ndive", "<p>Deep</p><p>dive</p>" ],
    ]
    assert_to_html_in_out(samples)
  end

  def est_to_chapters_top_headings
    samples = [
      [ 
        '{#}First Chapter', 
        { :chapters => [{ :title => 'First Chapter' }] }
      ],
      [ 
        '  {#}  Hey!! This is a Hot Chapter !! ', 
        { :chapters => [{ :title => 'Hey!! This is a Hot Chapter !!' }] }
      ],
      [ 
        "{#}First Chapter\n{#}Last Chapter", 
        { :chapters => [
            { :title => 'First Chapter' },
            { :title => 'Last Chapter' }
        ]}
      ],
    ]
    assert_to_chapters_in_out(samples)
  end

  def test_to_html_top_headings
    samples = [
      [ 
        '{#}First Chapter', 
        '<h2 id="1-first-chapter">First Chapter</h2>' 
      ],
      [ 
        '  {#}  Hey!! This is a Hot Chapter !! ', 
        '<h2 id="1-hey-this-is-a-hot-chapter-">Hey!! This is a Hot Chapter !!</h2>' 
      ],
      [ 
        "{#}First Chapter\n{#}Last Chapter", 
        '<h2 id="1-first-chapter">First Chapter</h2>' + 
        '<h2 id="2-last-chapter">Last Chapter</h2>' 
      ],
    ]
    assert_to_html_in_out(samples)
  end

  def est_to_chapters_sub_headings
    samples = [
      [ 
        "{#}First Chapter\n{##}Sub Chapter", 
        { :chapters => [
            { 
              :title    => 'First Chapter',
              :chapters => [ { :title => 'Last Chapter' } ]
            }
        ]}
      ],
      #[ 
        #"{#}First Chapter\n{#}Second Chapter\n{##}Sub Chapter", 
        #'<h2 id="1-first-chapter">First Chapter</h2>' +
        #'<h2 id="2-second-chapter">Second Chapter</h2>' +
        #'<h3 id="2.1-sub-chapter">Sub Chapter</h3>'
      #],
      #[ 
        #"{#}First Chapter\n{##}Sub Chapter\n{#}Second Chapter", 
        #'<h2 id="1-first-chapter">First Chapter</h2>' +
        #'<h3 id="1.1-sub-chapter">Sub Chapter</h3>' +
        #'<h2 id="2-second-chapter">Second Chapter</h2>'
      #],
      #[ 
        #"{#}First Chapter\n{##}Sub Chapter\n{###}Mini Chapter", 
        #'<h2 id="1-first-chapter">First Chapter</h2>' +
        #'<h3 id="1.1-sub-chapter">Sub Chapter</h3>' +
        #'<h4 id="1.1.1-mini-chapter">Mini Chapter</h4>'
      #],
      #[ 
        #"{#}First Chapter\n{##}Sub Chapter\n{#}Second Chapter\n{##}Sub Chapter\n{###}Mini Chapter", 
        #'<h2 id="1-first-chapter">First Chapter</h2>' +
        #'<h3 id="1.1-sub-chapter">Sub Chapter</h3>' +
        #'<h2 id="2-second-chapter">Second Chapter</h2>' +
        #'<h3 id="2.1-sub-chapter">Sub Chapter</h3>' +
        #'<h4 id="2.1.1-mini-chapter">Mini Chapter</h4>'
      #],
    ]
    assert_to_chapters_in_out(samples)
  end

  def test_to_html_sub_headings
    samples = [
      [ 
        "{#}First Chapter\n{##}Sub Chapter", 
        '<h2 id="1-first-chapter">First Chapter</h2>' +
        '<h3 id="1.1-sub-chapter">Sub Chapter</h3>'
      ],
      [ 
        "{#}First Chapter\n{#}Second Chapter\n{##}Sub Chapter", 
        '<h2 id="1-first-chapter">First Chapter</h2>' +
        '<h2 id="2-second-chapter">Second Chapter</h2>' +
        '<h3 id="2.1-sub-chapter">Sub Chapter</h3>'
      ],
      [ 
        "{#}First Chapter\n{##}Sub Chapter\n{#}Second Chapter", 
        '<h2 id="1-first-chapter">First Chapter</h2>' +
        '<h3 id="1.1-sub-chapter">Sub Chapter</h3>' +
        '<h2 id="2-second-chapter">Second Chapter</h2>'
      ],
      [ 
        "{#}First Chapter\n{##}Sub Chapter\n{###}Mini Chapter", 
        '<h2 id="1-first-chapter">First Chapter</h2>' +
        '<h3 id="1.1-sub-chapter">Sub Chapter</h3>' +
        '<h4 id="1.1.1-mini-chapter">Mini Chapter</h4>'
      ],
      [ 
        "{#}First Chapter\n{##}Sub Chapter\n{#}Second Chapter\n{##}Sub Chapter\n{###}Mini Chapter", 
        '<h2 id="1-first-chapter">First Chapter</h2>' +
        '<h3 id="1.1-sub-chapter">Sub Chapter</h3>' +
        '<h2 id="2-second-chapter">Second Chapter</h2>' +
        '<h3 id="2.1-sub-chapter">Sub Chapter</h3>' +
        '<h4 id="2.1.1-mini-chapter">Mini Chapter</h4>'
      ],
    ]
    assert_to_html_in_out(samples)
  end

  private

  def assert_to_html_in_out(samples)
    samples.each do |sample|
      assert_equal(sample[1], to_html(sample[0]))
    end
  end

  def assert_to_chapters_in_out(samples)
    samples.each do |sample|
      chapter = to_chapters(sample[0])
      assert(
        sample[1].eql?(chapter), 
        "Wrong chapter generated from '#{sample[0]}' : #{chapter} is not equal to #{sample[1]} "
      )
    end
  end

end
