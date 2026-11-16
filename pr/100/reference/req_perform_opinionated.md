# Perform a request with opinionated defaults

This function ensures that a request has
[`httr2::req_retry()`](https://httr2.r-lib.org/reference/req_retry.html)
applied, and then performs the request, using either
[`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html)
(if a `next_req_fn` function is supplied) or
[`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html)
(if not).

## Usage

``` r
req_perform_opinionated(
  req,
  ...,
  next_req_fn = choose_pagination_fn(req),
  max_reqs = 2,
  max_tries_per_req = 3
)
```

## Arguments

- req:

  The first [request](https://httr2.r-lib.org/reference/request.html) to
  perform.

- ...:

  These dots are for future extensions and must be empty.

- next_req_fn:

  (`function`) An optional function that takes the previous response
  (`resp`) and request (`req`), and returns a new request. This function
  is passed as `next_req` in a call to
  [`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html).
  This function can usually be generated using one of the iteration
  helpers described in
  [`httr2::iterate_with_offset()`](https://httr2.r-lib.org/reference/iterate_with_offset.html).
  By default,
  [`choose_pagination_fn()`](https://nectar.api2r.org/reference/choose_pagination_fn.md)
  is used to check for a pagination policy (see
  [`req_pagination_policy()`](https://nectar.api2r.org/reference/req_pagination_policy.md)),
  and returns `NULL` if no such policy is defined.

- max_reqs:

  (`length-1 integer`) The maximum number of separate requests to
  perform. Passed to the max_reqs argument of
  [`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html)
  when `next_req` is supplied. You will mostly likely want to change the
  default value (`2`) to `Inf` after you validate that the request
  works.

- max_tries_per_req:

  (`length-1 integer`) The maximum number of times to attempt each
  individual request. Passed to the `max_tries` argument of
  [`httr2::req_retry()`](https://httr2.r-lib.org/reference/req_retry.html).

## Value

Always returns a list of
[`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
objects, one for each request performed, to ensure that downstream
operations are the same regardless of the number of responses. The list
has additional class `nectar_responses`.

## Examples

``` r
# Performs a single request and returns a list of responses
req <- httr2::request("https://jsonplaceholder.typicode.com/posts")
resps <- req_perform_opinionated(req)
httr2::resp_status(resps[[1]])
#> [1] 200
resp_parse(resps, response_parser = resp_tidy_json)
#> [[1]]
#> [[1]]$userId
#> [1] 1
#> 
#> [[1]]$id
#> [1] 1
#> 
#> [[1]]$title
#> [1] "sunt aut facere repellat provident occaecati excepturi optio reprehenderit"
#> 
#> [[1]]$body
#> [1] "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
#> 
#> 
#> [[2]]
#> [[2]]$userId
#> [1] 1
#> 
#> [[2]]$id
#> [1] 2
#> 
#> [[2]]$title
#> [1] "qui est esse"
#> 
#> [[2]]$body
#> [1] "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
#> 
#> 
#> [[3]]
#> [[3]]$userId
#> [1] 1
#> 
#> [[3]]$id
#> [1] 3
#> 
#> [[3]]$title
#> [1] "ea molestias quasi exercitationem repellat qui ipsa sit aut"
#> 
#> [[3]]$body
#> [1] "et iusto sed quo iure\nvoluptatem occaecati omnis eligendi aut ad\nvoluptatem doloribus vel accusantium quis pariatur\nmolestiae porro eius odio et labore et velit aut"
#> 
#> 
#> [[4]]
#> [[4]]$userId
#> [1] 1
#> 
#> [[4]]$id
#> [1] 4
#> 
#> [[4]]$title
#> [1] "eum et est occaecati"
#> 
#> [[4]]$body
#> [1] "ullam et saepe reiciendis voluptatem adipisci\nsit amet autem assumenda provident rerum culpa\nquis hic commodi nesciunt rem tenetur doloremque ipsam iure\nquis sunt voluptatem rerum illo velit"
#> 
#> 
#> [[5]]
#> [[5]]$userId
#> [1] 1
#> 
#> [[5]]$id
#> [1] 5
#> 
#> [[5]]$title
#> [1] "nesciunt quas odio"
#> 
#> [[5]]$body
#> [1] "repudiandae veniam quaerat sunt sed\nalias aut fugiat sit autem sed est\nvoluptatem omnis possimus esse voluptatibus quis\nest aut tenetur dolor neque"
#> 
#> 
#> [[6]]
#> [[6]]$userId
#> [1] 1
#> 
#> [[6]]$id
#> [1] 6
#> 
#> [[6]]$title
#> [1] "dolorem eum magni eos aperiam quia"
#> 
#> [[6]]$body
#> [1] "ut aspernatur corporis harum nihil quis provident sequi\nmollitia nobis aliquid molestiae\nperspiciatis et ea nemo ab reprehenderit accusantium quas\nvoluptate dolores velit et doloremque molestiae"
#> 
#> 
#> [[7]]
#> [[7]]$userId
#> [1] 1
#> 
#> [[7]]$id
#> [1] 7
#> 
#> [[7]]$title
#> [1] "magnam facilis autem"
#> 
#> [[7]]$body
#> [1] "dolore placeat quibusdam ea quo vitae\nmagni quis enim qui quis quo nemo aut saepe\nquidem repellat excepturi ut quia\nsunt ut sequi eos ea sed quas"
#> 
#> 
#> [[8]]
#> [[8]]$userId
#> [1] 1
#> 
#> [[8]]$id
#> [1] 8
#> 
#> [[8]]$title
#> [1] "dolorem dolore est ipsam"
#> 
#> [[8]]$body
#> [1] "dignissimos aperiam dolorem qui eum\nfacilis quibusdam animi sint suscipit qui sint possimus cum\nquaerat magni maiores excepturi\nipsam ut commodi dolor voluptatum modi aut vitae"
#> 
#> 
#> [[9]]
#> [[9]]$userId
#> [1] 1
#> 
#> [[9]]$id
#> [1] 9
#> 
#> [[9]]$title
#> [1] "nesciunt iure omnis dolorem tempora et accusantium"
#> 
#> [[9]]$body
#> [1] "consectetur animi nesciunt iure dolore\nenim quia ad\nveniam autem ut quam aut nobis\net est aut quod aut provident voluptas autem voluptas"
#> 
#> 
#> [[10]]
#> [[10]]$userId
#> [1] 1
#> 
#> [[10]]$id
#> [1] 10
#> 
#> [[10]]$title
#> [1] "optio molestias id quia eum"
#> 
#> [[10]]$body
#> [1] "quo et expedita modi cum officia vel magni\ndoloribus qui repudiandae\nvero nisi sit\nquos veniam quod sed accusamus veritatis error"
#> 
#> 
#> [[11]]
#> [[11]]$userId
#> [1] 2
#> 
#> [[11]]$id
#> [1] 11
#> 
#> [[11]]$title
#> [1] "et ea vero quia laudantium autem"
#> 
#> [[11]]$body
#> [1] "delectus reiciendis molestiae occaecati non minima eveniet qui voluptatibus\naccusamus in eum beatae sit\nvel qui neque voluptates ut commodi qui incidunt\nut animi commodi"
#> 
#> 
#> [[12]]
#> [[12]]$userId
#> [1] 2
#> 
#> [[12]]$id
#> [1] 12
#> 
#> [[12]]$title
#> [1] "in quibusdam tempore odit est dolorem"
#> 
#> [[12]]$body
#> [1] "itaque id aut magnam\npraesentium quia et ea odit et ea voluptas et\nsapiente quia nihil amet occaecati quia id voluptatem\nincidunt ea est distinctio odio"
#> 
#> 
#> [[13]]
#> [[13]]$userId
#> [1] 2
#> 
#> [[13]]$id
#> [1] 13
#> 
#> [[13]]$title
#> [1] "dolorum ut in voluptas mollitia et saepe quo animi"
#> 
#> [[13]]$body
#> [1] "aut dicta possimus sint mollitia voluptas commodi quo doloremque\niste corrupti reiciendis voluptatem eius rerum\nsit cumque quod eligendi laborum minima\nperferendis recusandae assumenda consectetur porro architecto ipsum ipsam"
#> 
#> 
#> [[14]]
#> [[14]]$userId
#> [1] 2
#> 
#> [[14]]$id
#> [1] 14
#> 
#> [[14]]$title
#> [1] "voluptatem eligendi optio"
#> 
#> [[14]]$body
#> [1] "fuga et accusamus dolorum perferendis illo voluptas\nnon doloremque neque facere\nad qui dolorum molestiae beatae\nsed aut voluptas totam sit illum"
#> 
#> 
#> [[15]]
#> [[15]]$userId
#> [1] 2
#> 
#> [[15]]$id
#> [1] 15
#> 
#> [[15]]$title
#> [1] "eveniet quod temporibus"
#> 
#> [[15]]$body
#> [1] "reprehenderit quos placeat\nvelit minima officia dolores impedit repudiandae molestiae nam\nvoluptas recusandae quis delectus\nofficiis harum fugiat vitae"
#> 
#> 
#> [[16]]
#> [[16]]$userId
#> [1] 2
#> 
#> [[16]]$id
#> [1] 16
#> 
#> [[16]]$title
#> [1] "sint suscipit perspiciatis velit dolorum rerum ipsa laboriosam odio"
#> 
#> [[16]]$body
#> [1] "suscipit nam nisi quo aperiam aut\nasperiores eos fugit maiores voluptatibus quia\nvoluptatem quis ullam qui in alias quia est\nconsequatur magni mollitia accusamus ea nisi voluptate dicta"
#> 
#> 
#> [[17]]
#> [[17]]$userId
#> [1] 2
#> 
#> [[17]]$id
#> [1] 17
#> 
#> [[17]]$title
#> [1] "fugit voluptas sed molestias voluptatem provident"
#> 
#> [[17]]$body
#> [1] "eos voluptas et aut odit natus earum\naspernatur fuga molestiae ullam\ndeserunt ratione qui eos\nqui nihil ratione nemo velit ut aut id quo"
#> 
#> 
#> [[18]]
#> [[18]]$userId
#> [1] 2
#> 
#> [[18]]$id
#> [1] 18
#> 
#> [[18]]$title
#> [1] "voluptate et itaque vero tempora molestiae"
#> 
#> [[18]]$body
#> [1] "eveniet quo quis\nlaborum totam consequatur non dolor\nut et est repudiandae\nest voluptatem vel debitis et magnam"
#> 
#> 
#> [[19]]
#> [[19]]$userId
#> [1] 2
#> 
#> [[19]]$id
#> [1] 19
#> 
#> [[19]]$title
#> [1] "adipisci placeat illum aut reiciendis qui"
#> 
#> [[19]]$body
#> [1] "illum quis cupiditate provident sit magnam\nea sed aut omnis\nveniam maiores ullam consequatur atque\nadipisci quo iste expedita sit quos voluptas"
#> 
#> 
#> [[20]]
#> [[20]]$userId
#> [1] 2
#> 
#> [[20]]$id
#> [1] 20
#> 
#> [[20]]$title
#> [1] "doloribus ad provident suscipit at"
#> 
#> [[20]]$body
#> [1] "qui consequuntur ducimus possimus quisquam amet similique\nsuscipit porro ipsam amet\neos veritatis officiis exercitationem vel fugit aut necessitatibus totam\nomnis rerum consequatur expedita quidem cumque explicabo"
#> 
#> 
#> [[21]]
#> [[21]]$userId
#> [1] 3
#> 
#> [[21]]$id
#> [1] 21
#> 
#> [[21]]$title
#> [1] "asperiores ea ipsam voluptatibus modi minima quia sint"
#> 
#> [[21]]$body
#> [1] "repellat aliquid praesentium dolorem quo\nsed totam minus non itaque\nnihil labore molestiae sunt dolor eveniet hic recusandae veniam\ntempora et tenetur expedita sunt"
#> 
#> 
#> [[22]]
#> [[22]]$userId
#> [1] 3
#> 
#> [[22]]$id
#> [1] 22
#> 
#> [[22]]$title
#> [1] "dolor sint quo a velit explicabo quia nam"
#> 
#> [[22]]$body
#> [1] "eos qui et ipsum ipsam suscipit aut\nsed omnis non odio\nexpedita earum mollitia molestiae aut atque rem suscipit\nnam impedit esse"
#> 
#> 
#> [[23]]
#> [[23]]$userId
#> [1] 3
#> 
#> [[23]]$id
#> [1] 23
#> 
#> [[23]]$title
#> [1] "maxime id vitae nihil numquam"
#> 
#> [[23]]$body
#> [1] "veritatis unde neque eligendi\nquae quod architecto quo neque vitae\nest illo sit tempora doloremque fugit quod\net et vel beatae sequi ullam sed tenetur perspiciatis"
#> 
#> 
#> [[24]]
#> [[24]]$userId
#> [1] 3
#> 
#> [[24]]$id
#> [1] 24
#> 
#> [[24]]$title
#> [1] "autem hic labore sunt dolores incidunt"
#> 
#> [[24]]$body
#> [1] "enim et ex nulla\nomnis voluptas quia qui\nvoluptatem consequatur numquam aliquam sunt\ntotam recusandae id dignissimos aut sed asperiores deserunt"
#> 
#> 
#> [[25]]
#> [[25]]$userId
#> [1] 3
#> 
#> [[25]]$id
#> [1] 25
#> 
#> [[25]]$title
#> [1] "rem alias distinctio quo quis"
#> 
#> [[25]]$body
#> [1] "ullam consequatur ut\nomnis quis sit vel consequuntur\nipsa eligendi ipsum molestiae et omnis error nostrum\nmolestiae illo tempore quia et distinctio"
#> 
#> 
#> [[26]]
#> [[26]]$userId
#> [1] 3
#> 
#> [[26]]$id
#> [1] 26
#> 
#> [[26]]$title
#> [1] "est et quae odit qui non"
#> 
#> [[26]]$body
#> [1] "similique esse doloribus nihil accusamus\nomnis dolorem fuga consequuntur reprehenderit fugit recusandae temporibus\nperspiciatis cum ut laudantium\nomnis aut molestiae vel vero"
#> 
#> 
#> [[27]]
#> [[27]]$userId
#> [1] 3
#> 
#> [[27]]$id
#> [1] 27
#> 
#> [[27]]$title
#> [1] "quasi id et eos tenetur aut quo autem"
#> 
#> [[27]]$body
#> [1] "eum sed dolores ipsam sint possimus debitis occaecati\ndebitis qui qui et\nut placeat enim earum aut odit facilis\nconsequatur suscipit necessitatibus rerum sed inventore temporibus consequatur"
#> 
#> 
#> [[28]]
#> [[28]]$userId
#> [1] 3
#> 
#> [[28]]$id
#> [1] 28
#> 
#> [[28]]$title
#> [1] "delectus ullam et corporis nulla voluptas sequi"
#> 
#> [[28]]$body
#> [1] "non et quaerat ex quae ad maiores\nmaiores recusandae totam aut blanditiis mollitia quas illo\nut voluptatibus voluptatem\nsimilique nostrum eum"
#> 
#> 
#> [[29]]
#> [[29]]$userId
#> [1] 3
#> 
#> [[29]]$id
#> [1] 29
#> 
#> [[29]]$title
#> [1] "iusto eius quod necessitatibus culpa ea"
#> 
#> [[29]]$body
#> [1] "odit magnam ut saepe sed non qui\ntempora atque nihil\naccusamus illum doloribus illo dolor\neligendi repudiandae odit magni similique sed cum maiores"
#> 
#> 
#> [[30]]
#> [[30]]$userId
#> [1] 3
#> 
#> [[30]]$id
#> [1] 30
#> 
#> [[30]]$title
#> [1] "a quo magni similique perferendis"
#> 
#> [[30]]$body
#> [1] "alias dolor cumque\nimpedit blanditiis non eveniet odio maxime\nblanditiis amet eius quis tempora quia autem rem\na provident perspiciatis quia"
#> 
#> 
#> [[31]]
#> [[31]]$userId
#> [1] 4
#> 
#> [[31]]$id
#> [1] 31
#> 
#> [[31]]$title
#> [1] "ullam ut quidem id aut vel consequuntur"
#> 
#> [[31]]$body
#> [1] "debitis eius sed quibusdam non quis consectetur vitae\nimpedit ut qui consequatur sed aut in\nquidem sit nostrum et maiores adipisci atque\nquaerat voluptatem adipisci repudiandae"
#> 
#> 
#> [[32]]
#> [[32]]$userId
#> [1] 4
#> 
#> [[32]]$id
#> [1] 32
#> 
#> [[32]]$title
#> [1] "doloremque illum aliquid sunt"
#> 
#> [[32]]$body
#> [1] "deserunt eos nobis asperiores et hic\nest debitis repellat molestiae optio\nnihil ratione ut eos beatae quibusdam distinctio maiores\nearum voluptates et aut adipisci ea maiores voluptas maxime"
#> 
#> 
#> [[33]]
#> [[33]]$userId
#> [1] 4
#> 
#> [[33]]$id
#> [1] 33
#> 
#> [[33]]$title
#> [1] "qui explicabo molestiae dolorem"
#> 
#> [[33]]$body
#> [1] "rerum ut et numquam laborum odit est sit\nid qui sint in\nquasi tenetur tempore aperiam et quaerat qui in\nrerum officiis sequi cumque quod"
#> 
#> 
#> [[34]]
#> [[34]]$userId
#> [1] 4
#> 
#> [[34]]$id
#> [1] 34
#> 
#> [[34]]$title
#> [1] "magnam ut rerum iure"
#> 
#> [[34]]$body
#> [1] "ea velit perferendis earum ut voluptatem voluptate itaque iusto\ntotam pariatur in\nnemo voluptatem voluptatem autem magni tempora minima in\nest distinctio qui assumenda accusamus dignissimos officia nesciunt nobis"
#> 
#> 
#> [[35]]
#> [[35]]$userId
#> [1] 4
#> 
#> [[35]]$id
#> [1] 35
#> 
#> [[35]]$title
#> [1] "id nihil consequatur molestias animi provident"
#> 
#> [[35]]$body
#> [1] "nisi error delectus possimus ut eligendi vitae\nplaceat eos harum cupiditate facilis reprehenderit voluptatem beatae\nmodi ducimus quo illum voluptas eligendi\net nobis quia fugit"
#> 
#> 
#> [[36]]
#> [[36]]$userId
#> [1] 4
#> 
#> [[36]]$id
#> [1] 36
#> 
#> [[36]]$title
#> [1] "fuga nam accusamus voluptas reiciendis itaque"
#> 
#> [[36]]$body
#> [1] "ad mollitia et omnis minus architecto odit\nvoluptas doloremque maxime aut non ipsa qui alias veniam\nblanditiis culpa aut quia nihil cumque facere et occaecati\nqui aspernatur quia eaque ut aperiam inventore"
#> 
#> 
#> [[37]]
#> [[37]]$userId
#> [1] 4
#> 
#> [[37]]$id
#> [1] 37
#> 
#> [[37]]$title
#> [1] "provident vel ut sit ratione est"
#> 
#> [[37]]$body
#> [1] "debitis et eaque non officia sed nesciunt pariatur vel\nvoluptatem iste vero et ea\nnumquam aut expedita ipsum nulla in\nvoluptates omnis consequatur aut enim officiis in quam qui"
#> 
#> 
#> [[38]]
#> [[38]]$userId
#> [1] 4
#> 
#> [[38]]$id
#> [1] 38
#> 
#> [[38]]$title
#> [1] "explicabo et eos deleniti nostrum ab id repellendus"
#> 
#> [[38]]$body
#> [1] "animi esse sit aut sit nesciunt assumenda eum voluptas\nquia voluptatibus provident quia necessitatibus ea\nrerum repudiandae quia voluptatem delectus fugit aut id quia\nratione optio eos iusto veniam iure"
#> 
#> 
#> [[39]]
#> [[39]]$userId
#> [1] 4
#> 
#> [[39]]$id
#> [1] 39
#> 
#> [[39]]$title
#> [1] "eos dolorem iste accusantium est eaque quam"
#> 
#> [[39]]$body
#> [1] "corporis rerum ducimus vel eum accusantium\nmaxime aspernatur a porro possimus iste omnis\nest in deleniti asperiores fuga aut\nvoluptas sapiente vel dolore minus voluptatem incidunt ex"
#> 
#> 
#> [[40]]
#> [[40]]$userId
#> [1] 4
#> 
#> [[40]]$id
#> [1] 40
#> 
#> [[40]]$title
#> [1] "enim quo cumque"
#> 
#> [[40]]$body
#> [1] "ut voluptatum aliquid illo tenetur nemo sequi quo facilis\nipsum rem optio mollitia quas\nvoluptatem eum voluptas qui\nunde omnis voluptatem iure quasi maxime voluptas nam"
#> 
#> 
#> [[41]]
#> [[41]]$userId
#> [1] 5
#> 
#> [[41]]$id
#> [1] 41
#> 
#> [[41]]$title
#> [1] "non est facere"
#> 
#> [[41]]$body
#> [1] "molestias id nostrum\nexcepturi molestiae dolore omnis repellendus quaerat saepe\nconsectetur iste quaerat tenetur asperiores accusamus ex ut\nnam quidem est ducimus sunt debitis saepe"
#> 
#> 
#> [[42]]
#> [[42]]$userId
#> [1] 5
#> 
#> [[42]]$id
#> [1] 42
#> 
#> [[42]]$title
#> [1] "commodi ullam sint et excepturi error explicabo praesentium voluptas"
#> 
#> [[42]]$body
#> [1] "odio fugit voluptatum ducimus earum autem est incidunt voluptatem\nodit reiciendis aliquam sunt sequi nulla dolorem\nnon facere repellendus voluptates quia\nratione harum vitae ut"
#> 
#> 
#> [[43]]
#> [[43]]$userId
#> [1] 5
#> 
#> [[43]]$id
#> [1] 43
#> 
#> [[43]]$title
#> [1] "eligendi iste nostrum consequuntur adipisci praesentium sit beatae perferendis"
#> 
#> [[43]]$body
#> [1] "similique fugit est\nillum et dolorum harum et voluptate eaque quidem\nexercitationem quos nam commodi possimus cum odio nihil nulla\ndolorum exercitationem magnam ex et a et distinctio debitis"
#> 
#> 
#> [[44]]
#> [[44]]$userId
#> [1] 5
#> 
#> [[44]]$id
#> [1] 44
#> 
#> [[44]]$title
#> [1] "optio dolor molestias sit"
#> 
#> [[44]]$body
#> [1] "temporibus est consectetur dolore\net libero debitis vel velit laboriosam quia\nipsum quibusdam qui itaque fuga rem aut\nea et iure quam sed maxime ut distinctio quae"
#> 
#> 
#> [[45]]
#> [[45]]$userId
#> [1] 5
#> 
#> [[45]]$id
#> [1] 45
#> 
#> [[45]]$title
#> [1] "ut numquam possimus omnis eius suscipit laudantium iure"
#> 
#> [[45]]$body
#> [1] "est natus reiciendis nihil possimus aut provident\nex et dolor\nrepellat pariatur est\nnobis rerum repellendus dolorem autem"
#> 
#> 
#> [[46]]
#> [[46]]$userId
#> [1] 5
#> 
#> [[46]]$id
#> [1] 46
#> 
#> [[46]]$title
#> [1] "aut quo modi neque nostrum ducimus"
#> 
#> [[46]]$body
#> [1] "voluptatem quisquam iste\nvoluptatibus natus officiis facilis dolorem\nquis quas ipsam\nvel et voluptatum in aliquid"
#> 
#> 
#> [[47]]
#> [[47]]$userId
#> [1] 5
#> 
#> [[47]]$id
#> [1] 47
#> 
#> [[47]]$title
#> [1] "quibusdam cumque rem aut deserunt"
#> 
#> [[47]]$body
#> [1] "voluptatem assumenda ut qui ut cupiditate aut impedit veniam\noccaecati nemo illum voluptatem laudantium\nmolestiae beatae rerum ea iure soluta nostrum\neligendi et voluptate"
#> 
#> 
#> [[48]]
#> [[48]]$userId
#> [1] 5
#> 
#> [[48]]$id
#> [1] 48
#> 
#> [[48]]$title
#> [1] "ut voluptatem illum ea doloribus itaque eos"
#> 
#> [[48]]$body
#> [1] "voluptates quo voluptatem facilis iure occaecati\nvel assumenda rerum officia et\nillum perspiciatis ab deleniti\nlaudantium repellat ad ut et autem reprehenderit"
#> 
#> 
#> [[49]]
#> [[49]]$userId
#> [1] 5
#> 
#> [[49]]$id
#> [1] 49
#> 
#> [[49]]$title
#> [1] "laborum non sunt aut ut assumenda perspiciatis voluptas"
#> 
#> [[49]]$body
#> [1] "inventore ab sint\nnatus fugit id nulla sequi architecto nihil quaerat\neos tenetur in in eum veritatis non\nquibusdam officiis aspernatur cumque aut commodi aut"
#> 
#> 
#> [[50]]
#> [[50]]$userId
#> [1] 5
#> 
#> [[50]]$id
#> [1] 50
#> 
#> [[50]]$title
#> [1] "repellendus qui recusandae incidunt voluptates tenetur qui omnis exercitationem"
#> 
#> [[50]]$body
#> [1] "error suscipit maxime adipisci consequuntur recusandae\nvoluptas eligendi et est et voluptates\nquia distinctio ab amet quaerat molestiae et vitae\nadipisci impedit sequi nesciunt quis consectetur"
#> 
#> 
#> [[51]]
#> [[51]]$userId
#> [1] 6
#> 
#> [[51]]$id
#> [1] 51
#> 
#> [[51]]$title
#> [1] "soluta aliquam aperiam consequatur illo quis voluptas"
#> 
#> [[51]]$body
#> [1] "sunt dolores aut doloribus\ndolore doloribus voluptates tempora et\ndoloremque et quo\ncum asperiores sit consectetur dolorem"
#> 
#> 
#> [[52]]
#> [[52]]$userId
#> [1] 6
#> 
#> [[52]]$id
#> [1] 52
#> 
#> [[52]]$title
#> [1] "qui enim et consequuntur quia animi quis voluptate quibusdam"
#> 
#> [[52]]$body
#> [1] "iusto est quibusdam fuga quas quaerat molestias\na enim ut sit accusamus enim\ntemporibus iusto accusantium provident architecto\nsoluta esse reprehenderit qui laborum"
#> 
#> 
#> [[53]]
#> [[53]]$userId
#> [1] 6
#> 
#> [[53]]$id
#> [1] 53
#> 
#> [[53]]$title
#> [1] "ut quo aut ducimus alias"
#> 
#> [[53]]$body
#> [1] "minima harum praesentium eum rerum illo dolore\nquasi exercitationem rerum nam\nporro quis neque quo\nconsequatur minus dolor quidem veritatis sunt non explicabo similique"
#> 
#> 
#> [[54]]
#> [[54]]$userId
#> [1] 6
#> 
#> [[54]]$id
#> [1] 54
#> 
#> [[54]]$title
#> [1] "sit asperiores ipsam eveniet odio non quia"
#> 
#> [[54]]$body
#> [1] "totam corporis dignissimos\nvitae dolorem ut occaecati accusamus\nex velit deserunt\net exercitationem vero incidunt corrupti mollitia"
#> 
#> 
#> [[55]]
#> [[55]]$userId
#> [1] 6
#> 
#> [[55]]$id
#> [1] 55
#> 
#> [[55]]$title
#> [1] "sit vel voluptatem et non libero"
#> 
#> [[55]]$body
#> [1] "debitis excepturi ea perferendis harum libero optio\neos accusamus cum fuga ut sapiente repudiandae\net ut incidunt omnis molestiae\nnihil ut eum odit"
#> 
#> 
#> [[56]]
#> [[56]]$userId
#> [1] 6
#> 
#> [[56]]$id
#> [1] 56
#> 
#> [[56]]$title
#> [1] "qui et at rerum necessitatibus"
#> 
#> [[56]]$body
#> [1] "aut est omnis dolores\nneque rerum quod ea rerum velit pariatur beatae excepturi\net provident voluptas corrupti\ncorporis harum reprehenderit dolores eligendi"
#> 
#> 
#> [[57]]
#> [[57]]$userId
#> [1] 6
#> 
#> [[57]]$id
#> [1] 57
#> 
#> [[57]]$title
#> [1] "sed ab est est"
#> 
#> [[57]]$body
#> [1] "at pariatur consequuntur earum quidem\nquo est laudantium soluta voluptatem\nqui ullam et est\net cum voluptas voluptatum repellat est"
#> 
#> 
#> [[58]]
#> [[58]]$userId
#> [1] 6
#> 
#> [[58]]$id
#> [1] 58
#> 
#> [[58]]$title
#> [1] "voluptatum itaque dolores nisi et quasi"
#> 
#> [[58]]$body
#> [1] "veniam voluptatum quae adipisci id\net id quia eos ad et dolorem\naliquam quo nisi sunt eos impedit error\nad similique veniam"
#> 
#> 
#> [[59]]
#> [[59]]$userId
#> [1] 6
#> 
#> [[59]]$id
#> [1] 59
#> 
#> [[59]]$title
#> [1] "qui commodi dolor at maiores et quis id accusantium"
#> 
#> [[59]]$body
#> [1] "perspiciatis et quam ea autem temporibus non voluptatibus qui\nbeatae a earum officia nesciunt dolores suscipit voluptas et\nanimi doloribus cum rerum quas et magni\net hic ut ut commodi expedita sunt"
#> 
#> 
#> [[60]]
#> [[60]]$userId
#> [1] 6
#> 
#> [[60]]$id
#> [1] 60
#> 
#> [[60]]$title
#> [1] "consequatur placeat omnis quisquam quia reprehenderit fugit veritatis facere"
#> 
#> [[60]]$body
#> [1] "asperiores sunt ab assumenda cumque modi velit\nqui esse omnis\nvoluptate et fuga perferendis voluptas\nillo ratione amet aut et omnis"
#> 
#> 
#> [[61]]
#> [[61]]$userId
#> [1] 7
#> 
#> [[61]]$id
#> [1] 61
#> 
#> [[61]]$title
#> [1] "voluptatem doloribus consectetur est ut ducimus"
#> 
#> [[61]]$body
#> [1] "ab nemo optio odio\ndelectus tenetur corporis similique nobis repellendus rerum omnis facilis\nvero blanditiis debitis in nesciunt doloribus dicta dolores\nmagnam minus velit"
#> 
#> 
#> [[62]]
#> [[62]]$userId
#> [1] 7
#> 
#> [[62]]$id
#> [1] 62
#> 
#> [[62]]$title
#> [1] "beatae enim quia vel"
#> 
#> [[62]]$body
#> [1] "enim aspernatur illo distinctio quae praesentium\nbeatae alias amet delectus qui voluptate distinctio\nodit sint accusantium autem omnis\nquo molestiae omnis ea eveniet optio"
#> 
#> 
#> [[63]]
#> [[63]]$userId
#> [1] 7
#> 
#> [[63]]$id
#> [1] 63
#> 
#> [[63]]$title
#> [1] "voluptas blanditiis repellendus animi ducimus error sapiente et suscipit"
#> 
#> [[63]]$body
#> [1] "enim adipisci aspernatur nemo\nnumquam omnis facere dolorem dolor ex quis temporibus incidunt\nab delectus culpa quo reprehenderit blanditiis asperiores\naccusantium ut quam in voluptatibus voluptas ipsam dicta"
#> 
#> 
#> [[64]]
#> [[64]]$userId
#> [1] 7
#> 
#> [[64]]$id
#> [1] 64
#> 
#> [[64]]$title
#> [1] "et fugit quas eum in in aperiam quod"
#> 
#> [[64]]$body
#> [1] "id velit blanditiis\neum ea voluptatem\nmolestiae sint occaecati est eos perspiciatis\nincidunt a error provident eaque aut aut qui"
#> 
#> 
#> [[65]]
#> [[65]]$userId
#> [1] 7
#> 
#> [[65]]$id
#> [1] 65
#> 
#> [[65]]$title
#> [1] "consequatur id enim sunt et et"
#> 
#> [[65]]$body
#> [1] "voluptatibus ex esse\nsint explicabo est aliquid cumque adipisci fuga repellat labore\nmolestiae corrupti ex saepe at asperiores et perferendis\nnatus id esse incidunt pariatur"
#> 
#> 
#> [[66]]
#> [[66]]$userId
#> [1] 7
#> 
#> [[66]]$id
#> [1] 66
#> 
#> [[66]]$title
#> [1] "repudiandae ea animi iusto"
#> 
#> [[66]]$body
#> [1] "officia veritatis tenetur vero qui itaque\nsint non ratione\nsed et ut asperiores iusto eos molestiae nostrum\nveritatis quibusdam et nemo iusto saepe"
#> 
#> 
#> [[67]]
#> [[67]]$userId
#> [1] 7
#> 
#> [[67]]$id
#> [1] 67
#> 
#> [[67]]$title
#> [1] "aliquid eos sed fuga est maxime repellendus"
#> 
#> [[67]]$body
#> [1] "reprehenderit id nostrum\nvoluptas doloremque pariatur sint et accusantium quia quod aspernatur\net fugiat amet\nnon sapiente et consequatur necessitatibus molestiae"
#> 
#> 
#> [[68]]
#> [[68]]$userId
#> [1] 7
#> 
#> [[68]]$id
#> [1] 68
#> 
#> [[68]]$title
#> [1] "odio quis facere architecto reiciendis optio"
#> 
#> [[68]]$body
#> [1] "magnam molestiae perferendis quisquam\nqui cum reiciendis\nquaerat animi amet hic inventore\nea quia deleniti quidem saepe porro velit"
#> 
#> 
#> [[69]]
#> [[69]]$userId
#> [1] 7
#> 
#> [[69]]$id
#> [1] 69
#> 
#> [[69]]$title
#> [1] "fugiat quod pariatur odit minima"
#> 
#> [[69]]$body
#> [1] "officiis error culpa consequatur modi asperiores et\ndolorum assumenda voluptas et vel qui aut vel rerum\nvoluptatum quisquam perspiciatis quia rerum consequatur totam quas\nsequi commodi repudiandae asperiores et saepe a"
#> 
#> 
#> [[70]]
#> [[70]]$userId
#> [1] 7
#> 
#> [[70]]$id
#> [1] 70
#> 
#> [[70]]$title
#> [1] "voluptatem laborum magni"
#> 
#> [[70]]$body
#> [1] "sunt repellendus quae\nest asperiores aut deleniti esse accusamus repellendus quia aut\nquia dolorem unde\neum tempora esse dolore"
#> 
#> 
#> [[71]]
#> [[71]]$userId
#> [1] 8
#> 
#> [[71]]$id
#> [1] 71
#> 
#> [[71]]$title
#> [1] "et iusto veniam et illum aut fuga"
#> 
#> [[71]]$body
#> [1] "occaecati a doloribus\niste saepe consectetur placeat eum voluptate dolorem et\nqui quo quia voluptas\nrerum ut id enim velit est perferendis"
#> 
#> 
#> [[72]]
#> [[72]]$userId
#> [1] 8
#> 
#> [[72]]$id
#> [1] 72
#> 
#> [[72]]$title
#> [1] "sint hic doloribus consequatur eos non id"
#> 
#> [[72]]$body
#> [1] "quam occaecati qui deleniti consectetur\nconsequatur aut facere quas exercitationem aliquam hic voluptas\nneque id sunt ut aut accusamus\nsunt consectetur expedita inventore velit"
#> 
#> 
#> [[73]]
#> [[73]]$userId
#> [1] 8
#> 
#> [[73]]$id
#> [1] 73
#> 
#> [[73]]$title
#> [1] "consequuntur deleniti eos quia temporibus ab aliquid at"
#> 
#> [[73]]$body
#> [1] "voluptatem cumque tenetur consequatur expedita ipsum nemo quia explicabo\naut eum minima consequatur\ntempore cumque quae est et\net in consequuntur voluptatem voluptates aut"
#> 
#> 
#> [[74]]
#> [[74]]$userId
#> [1] 8
#> 
#> [[74]]$id
#> [1] 74
#> 
#> [[74]]$title
#> [1] "enim unde ratione doloribus quas enim ut sit sapiente"
#> 
#> [[74]]$body
#> [1] "odit qui et et necessitatibus sint veniam\nmollitia amet doloremque molestiae commodi similique magnam et quam\nblanditiis est itaque\nquo et tenetur ratione occaecati molestiae tempora"
#> 
#> 
#> [[75]]
#> [[75]]$userId
#> [1] 8
#> 
#> [[75]]$id
#> [1] 75
#> 
#> [[75]]$title
#> [1] "dignissimos eum dolor ut enim et delectus in"
#> 
#> [[75]]$body
#> [1] "commodi non non omnis et voluptas sit\nautem aut nobis magnam et sapiente voluptatem\net laborum repellat qui delectus facilis temporibus\nrerum amet et nemo voluptate expedita adipisci error dolorem"
#> 
#> 
#> [[76]]
#> [[76]]$userId
#> [1] 8
#> 
#> [[76]]$id
#> [1] 76
#> 
#> [[76]]$title
#> [1] "doloremque officiis ad et non perferendis"
#> 
#> [[76]]$body
#> [1] "ut animi facere\ntotam iusto tempore\nmolestiae eum aut et dolorem aperiam\nquaerat recusandae totam odio"
#> 
#> 
#> [[77]]
#> [[77]]$userId
#> [1] 8
#> 
#> [[77]]$id
#> [1] 77
#> 
#> [[77]]$title
#> [1] "necessitatibus quasi exercitationem odio"
#> 
#> [[77]]$body
#> [1] "modi ut in nulla repudiandae dolorum nostrum eos\naut consequatur omnis\nut incidunt est omnis iste et quam\nvoluptates sapiente aliquam asperiores nobis amet corrupti repudiandae provident"
#> 
#> 
#> [[78]]
#> [[78]]$userId
#> [1] 8
#> 
#> [[78]]$id
#> [1] 78
#> 
#> [[78]]$title
#> [1] "quam voluptatibus rerum veritatis"
#> 
#> [[78]]$body
#> [1] "nobis facilis odit tempore cupiditate quia\nassumenda doloribus rerum qui ea\nillum et qui totam\naut veniam repellendus"
#> 
#> 
#> [[79]]
#> [[79]]$userId
#> [1] 8
#> 
#> [[79]]$id
#> [1] 79
#> 
#> [[79]]$title
#> [1] "pariatur consequatur quia magnam autem omnis non amet"
#> 
#> [[79]]$body
#> [1] "libero accusantium et et facere incidunt sit dolorem\nnon excepturi qui quia sed laudantium\nquisquam molestiae ducimus est\nofficiis esse molestiae iste et quos"
#> 
#> 
#> [[80]]
#> [[80]]$userId
#> [1] 8
#> 
#> [[80]]$id
#> [1] 80
#> 
#> [[80]]$title
#> [1] "labore in ex et explicabo corporis aut quas"
#> 
#> [[80]]$body
#> [1] "ex quod dolorem ea eum iure qui provident amet\nquia qui facere excepturi et repudiandae\nasperiores molestias provident\nminus incidunt vero fugit rerum sint sunt excepturi provident"
#> 
#> 
#> [[81]]
#> [[81]]$userId
#> [1] 9
#> 
#> [[81]]$id
#> [1] 81
#> 
#> [[81]]$title
#> [1] "tempora rem veritatis voluptas quo dolores vero"
#> 
#> [[81]]$body
#> [1] "facere qui nesciunt est voluptatum voluptatem nisi\nsequi eligendi necessitatibus ea at rerum itaque\nharum non ratione velit laboriosam quis consequuntur\nex officiis minima doloremque voluptas ut aut"
#> 
#> 
#> [[82]]
#> [[82]]$userId
#> [1] 9
#> 
#> [[82]]$id
#> [1] 82
#> 
#> [[82]]$title
#> [1] "laudantium voluptate suscipit sunt enim enim"
#> 
#> [[82]]$body
#> [1] "ut libero sit aut totam inventore sunt\nporro sint qui sunt molestiae\nconsequatur cupiditate qui iste ducimus adipisci\ndolor enim assumenda soluta laboriosam amet iste delectus hic"
#> 
#> 
#> [[83]]
#> [[83]]$userId
#> [1] 9
#> 
#> [[83]]$id
#> [1] 83
#> 
#> [[83]]$title
#> [1] "odit et voluptates doloribus alias odio et"
#> 
#> [[83]]$body
#> [1] "est molestiae facilis quis tempora numquam nihil qui\nvoluptate sapiente consequatur est qui\nnecessitatibus autem aut ipsa aperiam modi dolore numquam\nreprehenderit eius rem quibusdam"
#> 
#> 
#> [[84]]
#> [[84]]$userId
#> [1] 9
#> 
#> [[84]]$id
#> [1] 84
#> 
#> [[84]]$title
#> [1] "optio ipsam molestias necessitatibus occaecati facilis veritatis dolores aut"
#> 
#> [[84]]$body
#> [1] "sint molestiae magni a et quos\neaque et quasi\nut rerum debitis similique veniam\nrecusandae dignissimos dolor incidunt consequatur odio"
#> 
#> 
#> [[85]]
#> [[85]]$userId
#> [1] 9
#> 
#> [[85]]$id
#> [1] 85
#> 
#> [[85]]$title
#> [1] "dolore veritatis porro provident adipisci blanditiis et sunt"
#> 
#> [[85]]$body
#> [1] "similique sed nisi voluptas iusto omnis\nmollitia et quo\nassumenda suscipit officia magnam sint sed tempora\nenim provident pariatur praesentium atque animi amet ratione"
#> 
#> 
#> [[86]]
#> [[86]]$userId
#> [1] 9
#> 
#> [[86]]$id
#> [1] 86
#> 
#> [[86]]$title
#> [1] "placeat quia et porro iste"
#> 
#> [[86]]$body
#> [1] "quasi excepturi consequatur iste autem temporibus sed molestiae beatae\net quaerat et esse ut\nvoluptatem occaecati et vel explicabo autem\nasperiores pariatur deserunt optio"
#> 
#> 
#> [[87]]
#> [[87]]$userId
#> [1] 9
#> 
#> [[87]]$id
#> [1] 87
#> 
#> [[87]]$title
#> [1] "nostrum quis quasi placeat"
#> 
#> [[87]]$body
#> [1] "eos et molestiae\nnesciunt ut a\ndolores perspiciatis repellendus repellat aliquid\nmagnam sint rem ipsum est"
#> 
#> 
#> [[88]]
#> [[88]]$userId
#> [1] 9
#> 
#> [[88]]$id
#> [1] 88
#> 
#> [[88]]$title
#> [1] "sapiente omnis fugit eos"
#> 
#> [[88]]$body
#> [1] "consequatur omnis est praesentium\nducimus non iste\nneque hic deserunt\nvoluptatibus veniam cum et rerum sed"
#> 
#> 
#> [[89]]
#> [[89]]$userId
#> [1] 9
#> 
#> [[89]]$id
#> [1] 89
#> 
#> [[89]]$title
#> [1] "sint soluta et vel magnam aut ut sed qui"
#> 
#> [[89]]$body
#> [1] "repellat aut aperiam totam temporibus autem et\narchitecto magnam ut\nconsequatur qui cupiditate rerum quia soluta dignissimos nihil iure\ntempore quas est"
#> 
#> 
#> [[90]]
#> [[90]]$userId
#> [1] 9
#> 
#> [[90]]$id
#> [1] 90
#> 
#> [[90]]$title
#> [1] "ad iusto omnis odit dolor voluptatibus"
#> 
#> [[90]]$body
#> [1] "minus omnis soluta quia\nqui sed adipisci voluptates illum ipsam voluptatem\neligendi officia ut in\neos soluta similique molestias praesentium blanditiis"
#> 
#> 
#> [[91]]
#> [[91]]$userId
#> [1] 10
#> 
#> [[91]]$id
#> [1] 91
#> 
#> [[91]]$title
#> [1] "aut amet sed"
#> 
#> [[91]]$body
#> [1] "libero voluptate eveniet aperiam sed\nsunt placeat suscipit molestias\nsimilique fugit nam natus\nexpedita consequatur consequatur dolores quia eos et placeat"
#> 
#> 
#> [[92]]
#> [[92]]$userId
#> [1] 10
#> 
#> [[92]]$id
#> [1] 92
#> 
#> [[92]]$title
#> [1] "ratione ex tenetur perferendis"
#> 
#> [[92]]$body
#> [1] "aut et excepturi dicta laudantium sint rerum nihil\nlaudantium et at\na neque minima officia et similique libero et\ncommodi voluptate qui"
#> 
#> 
#> [[93]]
#> [[93]]$userId
#> [1] 10
#> 
#> [[93]]$id
#> [1] 93
#> 
#> [[93]]$title
#> [1] "beatae soluta recusandae"
#> 
#> [[93]]$body
#> [1] "dolorem quibusdam ducimus consequuntur dicta aut quo laboriosam\nvoluptatem quis enim recusandae ut sed sunt\nnostrum est odit totam\nsit error sed sunt eveniet provident qui nulla"
#> 
#> 
#> [[94]]
#> [[94]]$userId
#> [1] 10
#> 
#> [[94]]$id
#> [1] 94
#> 
#> [[94]]$title
#> [1] "qui qui voluptates illo iste minima"
#> 
#> [[94]]$body
#> [1] "aspernatur expedita soluta quo ab ut similique\nexpedita dolores amet\nsed temporibus distinctio magnam saepe deleniti\nomnis facilis nam ipsum natus sint similique omnis"
#> 
#> 
#> [[95]]
#> [[95]]$userId
#> [1] 10
#> 
#> [[95]]$id
#> [1] 95
#> 
#> [[95]]$title
#> [1] "id minus libero illum nam ad officiis"
#> 
#> [[95]]$body
#> [1] "earum voluptatem facere provident blanditiis velit laboriosam\npariatur accusamus odio saepe\ncumque dolor qui a dicta ab doloribus consequatur omnis\ncorporis cupiditate eaque assumenda ad nesciunt"
#> 
#> 
#> [[96]]
#> [[96]]$userId
#> [1] 10
#> 
#> [[96]]$id
#> [1] 96
#> 
#> [[96]]$title
#> [1] "quaerat velit veniam amet cupiditate aut numquam ut sequi"
#> 
#> [[96]]$body
#> [1] "in non odio excepturi sint eum\nlabore voluptates vitae quia qui et\ninventore itaque rerum\nveniam non exercitationem delectus aut"
#> 
#> 
#> [[97]]
#> [[97]]$userId
#> [1] 10
#> 
#> [[97]]$id
#> [1] 97
#> 
#> [[97]]$title
#> [1] "quas fugiat ut perspiciatis vero provident"
#> 
#> [[97]]$body
#> [1] "eum non blanditiis soluta porro quibusdam voluptas\nvel voluptatem qui placeat dolores qui velit aut\nvel inventore aut cumque culpa explicabo aliquid at\nperspiciatis est et voluptatem dignissimos dolor itaque sit nam"
#> 
#> 
#> [[98]]
#> [[98]]$userId
#> [1] 10
#> 
#> [[98]]$id
#> [1] 98
#> 
#> [[98]]$title
#> [1] "laboriosam dolor voluptates"
#> 
#> [[98]]$body
#> [1] "doloremque ex facilis sit sint culpa\nsoluta assumenda eligendi non ut eius\nsequi ducimus vel quasi\nveritatis est dolores"
#> 
#> 
#> [[99]]
#> [[99]]$userId
#> [1] 10
#> 
#> [[99]]$id
#> [1] 99
#> 
#> [[99]]$title
#> [1] "temporibus sit alias delectus eligendi possimus magni"
#> 
#> [[99]]$body
#> [1] "quo deleniti praesentium dicta non quod\naut est molestias\nmolestias et officia quis nihil\nitaque dolorem quia"
#> 
#> 
#> [[100]]
#> [[100]]$userId
#> [1] 10
#> 
#> [[100]]$id
#> [1] 100
#> 
#> [[100]]$title
#> [1] "at nam consequatur ea labore ea harum"
#> 
#> [[100]]$body
#> [1] "cupiditate quo est a modi nesciunt soluta\nipsa voluptas error itaque dicta in\nautem qui minus magnam et distinctio eum\naccusamus ratione error aut"
#> 
#> 
```
