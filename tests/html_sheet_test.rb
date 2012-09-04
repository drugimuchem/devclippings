require 'test/unit'
require './lib/html_sheet'

class HtmlSheetTest < Test::Unit::TestCase

  def test_to_html_basic
    samples = [
      [ '', '' ],
      [ "Deep dive", '<div class="text">Deep dive</div>' ],
      [ "Deep\ndive", "<div class=\"text\">Deep\ndive</div>" ],
    ]
    assert_to_html_in_out(samples)
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
      [ 
        "{#}First Chapter\nSomething else\n{#}Last Chapter", 
        '<h2 id="1-first-chapter">First Chapter</h2>' + 
				'<div class="text">Something else</div>' +
        '<h2 id="2-last-chapter">Last Chapter</h2>' 
      ],
    ]
    assert_to_html_in_out(samples)
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
        "{#}First Chapter\n{#}Second Chapter\n{##}Sub Chapter\n{###}Mini Chapter", 
        '<h2 id="1-first-chapter">First Chapter</h2>' +
        '<h2 id="2-second-chapter">Second Chapter</h2>' +
        '<h3 id="2.1-sub-chapter">Sub Chapter</h3>' +
        '<h4 id="2.1.1-mini-chapter">Mini Chapter</h4>'
      ],
      [ 
        "{#}First Chapter\n{##}Sub Chapter\n{#}Second Chapter\n{##}Sub Chapter\n{###}Mini Chapter", 
        '<h2 id="1-first-chapter">First Chapter</h2>' +
        '<h3 id="1.1-sub-chapter">Sub Chapter</h3>' +
        '<h2 id="2-second-chapter">Second Chapter</h2>' +
        '<h3 id="2.1-sub-chapter">Sub Chapter</h3>' +
        '<h4 id="2.1.1-mini-chapter">Mini Chapter</h4>'
      ],
      [ 
        "{#}First Chapter\n{##}Sub Chapter\n{#}Second Chapter\n{##}Sub Chapter\n{###}Mini Chapter\n{##}Next Sub Chapter\n{###}Another Mini Chapter", 
        '<h2 id="1-first-chapter">First Chapter</h2>' +
        '<h3 id="1.1-sub-chapter">Sub Chapter</h3>' +
        '<h2 id="2-second-chapter">Second Chapter</h2>' +
        '<h3 id="2.1-sub-chapter">Sub Chapter</h3>' +
        '<h4 id="2.1.1-mini-chapter">Mini Chapter</h4>' +
        '<h3 id="2.2-next-sub-chapter">Next Sub Chapter</h3>' +
        '<h4 id="2.2.1-another-mini-chapter">Another Mini Chapter</h4>'
      ],
      [ 
        "{#}First Chapter\nYep  \n{##}Sub Chapter\n{#}Second Chapter\n{##}Sub Chapter\n{###}Mini Chapter\n   Exactly\n{##}Next Sub Chapter\n{###}Another Mini Chapter", 
        '<h2 id="1-first-chapter">First Chapter</h2>' +
				'<div class="text">Yep  </div>' +
        '<h3 id="1.1-sub-chapter">Sub Chapter</h3>' +
        '<h2 id="2-second-chapter">Second Chapter</h2>' +
        '<h3 id="2.1-sub-chapter">Sub Chapter</h3>' +
        '<h4 id="2.1.1-mini-chapter">Mini Chapter</h4>' +
				'<div class="text">   Exactly</div>' +
        '<h3 id="2.2-next-sub-chapter">Next Sub Chapter</h3>' +
        '<h4 id="2.2.1-another-mini-chapter">Another Mini Chapter</h4>'
      ],
    ]
    assert_to_html_in_out(samples)
  end

  private

  def assert_to_html_in_out(samples)
    samples.each do |sample|
      assert_equal(sample[1], HtmlSheet.to_html(sample[0]))
    end
  end

end
