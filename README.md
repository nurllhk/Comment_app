# Comment_app

![bringing original ideas to life](https://user-images.githubusercontent.com/79688257/216465440-e9e99560-c913-478e-9981-f7eac61b0996.png)




```sh
gh repo clone nurllhk/Comment_app
```



 # Contents
  
  - [Screenshots]()
  
  - [Tested devices]()
  
  - [sample codes]()
  
  - [API working logic]()
  
  - [Connected database]()
  
  - [All files](https://github.com/nurllhk/Comment_app/archive/refs/heads/main.zip)
  
  
  
 # Overview
 
 -This project is a project that people can write about the products they use, the places they visit or the movies they watch, with a 300+ word comment and 4+ photos to share and earn money. The main income source of the project was started as adsense and ezoic. Users not only share reviews, but also spend time, resulting in a 0.0001 balance increase every 10 seconds. Each time users' reviews are viewed, an additional fee is earned on the statement. This project consists of 3 levels: the first level qualifies as 0-5000 points, the second level qualifies as 5000-10000 points and the third level is 10000+ points.
 
```sh 
 $price = 0.0001;

$statment = $db->prepare("UPDATE users SET balance=balance+'$price' where id=? ");
$statment->execute([$_GET['id']]);



if(statement){
    
    $a=$db->prepare("SELECT * FROM users where id=:id");
    $a->execute(['id' => $_GET['id']]);
    $acek=$a->fetch(PDO::FETCH_ASSOC);
    
    $total =$acek['balance']+ 0.0001;
    
    // NK
    
    $desc = "Sitede Kalma Kazancı";
    $time = "time_pay";
    
    $data_id = strtotime(date('d.m.Y H:i:s'));
 

    $sql=$db->prepare("INSERT INTO user_balances SET u_id=?,amount=?,before_balance=?,last_balance=?,description=?,data_type=?,data_id=?");
    $sql->execute([$_GET['id'],0.0001,$acek['balance'],$total,$desc,$time,$data_id]);
 
 ```
 
 * Scoring
    * approved comment 5 points
    * first comment on the product 6 points
    * word rate 50 points
    * spelling rules 8 points
    * added photo 10 points
    * high resolution photo 15 points
    * comment and paragraph placement 20 points
    
  
  
  
  
  

![Adsız tasarım](https://user-images.githubusercontent.com/79688257/216473203-25872da6-3f7e-46de-a163-0b9246719b70.png) ![Adsız tasarım-2](https://user-images.githubusercontent.com/79688257/216474268-fed6e4fe-5601-4262-9ce6-0fd7b42dc661.png) ![Adsız tasarım-3](https://user-images.githubusercontent.com/79688257/216474478-cd9c7a5e-f6d5-4d3d-a09f-f5f8cb46f944.png)![Adsız tasarım-4](https://user-images.githubusercontent.com/79688257/216549598-ef534eb4-5000-4ce3-9189-46aacb87341d.png)![Adsız tasarım-5](https://user-images.githubusercontent.com/79688257/216549946-d1e034a4-0c43-4e46-9957-5d194f488273.png)![Adsız tasarım-6](https://user-images.githubusercontent.com/79688257/216550484-b243cd7d-c0ed-49dc-8979-b402a2f26655.png)








# Product Name
> Short blurb about what your product does.

[![NPM Version][npm-image]][npm-url]
[![Build Status][travis-image]][travis-url]
[![Downloads Stats][npm-downloads]][npm-url]

One to two paragraph statement about your product and what it does.

![](header.png)

Windows:

```sh
edit autoexec.bat
```

## Usage example

A few motivating and useful examples of how your product can be used. Spice this up with code blocks and potentially more screenshots.

_For more examples and usage, please refer to the [Wiki][wiki]._

## Development setup

Describe how to install all development dependencies and how to run an automated test-suite of some kind. Potentially do this for multiple platforms.

```sh
make install
npm test
```



## APIs used

* Users
   
* Messages
  
* Rewiev

* Ads

* Test

* Products

* Comment

  



## Release History

* 2.0.1
    * photo update balance request review number and support request opening platforms from user account are finished
    * The comments on the homepage were updated and the last added review appeared on the page.
* 2.0.0
    * Starting from using firebase to run google apps on google cloud platform 
* 1.1.1
    * Performing internal operations with API files
* 1.0.0
    * the design is the same as the direct web page

## Meta

Your Name – [@webdunyamda](https://twitter.com/webdunyamda) – kayanurullah538@gmail.com


## Contributing

1. Fork it (<https://github.com/yourname/yourproject/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

<!-- Markdown link & img dfn's -->
[npm-image]: https://img.shields.io/npm/v/datadog-metrics.svg?style=flat-square
[npm-url]: https://npmjs.org/package/datadog-metrics
[npm-downloads]: https://img.shields.io/npm/dm/datadog-metrics.svg?style=flat-square
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[wiki]: https://github.com/yourname/yourproject/wiki
