Feature: Pagination
  As a content publisher
  I want to paginate my pages
  so that my audience can better digest my content

  Scenario: Paginator is disabled by default.
    Given some files with values:
        | file | body |
        | essays/hello.md | some hello content |
        | essays/goodbye.md | some goodbye content |
        | essays/caio.md | some caio content |
    When I compile my site
    Then my compiled site should NOT have the file "essays/index/1/index.html"

  Scenario: Enabling paginator and defining multiple pages in the same collection.
    Given a config file with values:
      | essays | { "paginator" : { "enable" : true } } |
      And some files with values:
        | file | body |
        | essays/hello.md | some hello content |
        | essays/goodbye.md | some goodbye content |
        | essays/caio.md | some caio content |
    When I compile my site
    Then my compiled site should have the file "essays/index/1/index.html"
      And this file should have the links "/essays/hello, /essays/goodbye, /essays/caio"

  Scenario: Configuring per_page and generating multiple pagination pages.
    Given a config file with values:
      | essays | { "paginator" : { "enable" : true, "per_page" : 1 } } |
      And some files with values:
        | file | body |
        | essays/hello.md | some hello content |
        | essays/goodbye.md | some goodbye content |
        | essays/caio.md | some caio content |
    When I compile my site
    Then my compiled site should have the file "essays/index/1/index.html"
      And this file should have the links "/essays/caio, /essays/index/2, /essays/index/3"
    Then my compiled site should have the file "essays/index/2/index.html"
      And this file should have the links "/essays/goodbye, /essays/index/1, /essays/index/3"
    Then my compiled site should have the file "essays/index/3/index.html"
      And this file should have the links "/essays/hello, /essays/index/1, /essays/index/2"
      And this file should NOT have the links "/essays/index/4"
    Then my compiled site should NOT have the file "essays/index/4/index.html"
