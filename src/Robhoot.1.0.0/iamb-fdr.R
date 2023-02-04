


<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    
    <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
          (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-462338-14', 'auto');
  ga('require', 'GTM-TKM62DV');
  ga('send', 'pageview', {
    
  });


  var trackOutboundLink = function(url) {
    ga('send', 'event', 'outbound', 'click', url, {
       'transport': 'beacon',
       'hitCallback': function(){document.location = url;}
    });
  }
</script>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1">
    <meta property="og:title" content="bnlearn source: R/iamb-fdr.R" />
    
      <meta name="description" content="R/iamb-fdr.R defines the following functions: ia.detect.infinite.loop ia.fdr.markov.blanket incremental.association.fdr">
      <meta property="og:description" content="R/iamb-fdr.R defines the following functions: ia.detect.infinite.loop ia.fdr.markov.blanket incremental.association.fdr"/>
    

    <link rel="icon" href="/favicon.ico">

    
    <link rel="canonical" href="https://rdrr.io/cran/bnlearn/src/R/iamb-fdr.R" />

    <link rel="search" type="application/opensearchdescription+xml" title="R Package Documentation" href="/opensearch.xml" />

    <!-- Hello from de3  -->

    <title>bnlearn source: R/iamb-fdr.R</title>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    
      
      
<link rel="stylesheet" href="/static/CACHE/css/e738a11ac285.css" type="text/css" />

    

    
  <style>
    .hll { background-color: #ffffcc }
.pyg-c { color: #408080; font-style: italic } /* Comment */
.pyg-err { border: 1px solid #FF0000 } /* Error */
.pyg-k { color: #008000; font-weight: bold } /* Keyword */
.pyg-o { color: #666666 } /* Operator */
.pyg-ch { color: #408080; font-style: italic } /* Comment.Hashbang */
.pyg-cm { color: #408080; font-style: italic } /* Comment.Multiline */
.pyg-cp { color: #BC7A00 } /* Comment.Preproc */
.pyg-cpf { color: #408080; font-style: italic } /* Comment.PreprocFile */
.pyg-c1 { color: #408080; font-style: italic } /* Comment.Single */
.pyg-cs { color: #408080; font-style: italic } /* Comment.Special */
.pyg-gd { color: #A00000 } /* Generic.Deleted */
.pyg-ge { font-style: italic } /* Generic.Emph */
.pyg-gr { color: #FF0000 } /* Generic.Error */
.pyg-gh { color: #000080; font-weight: bold } /* Generic.Heading */
.pyg-gi { color: #00A000 } /* Generic.Inserted */
.pyg-go { color: #888888 } /* Generic.Output */
.pyg-gp { color: #000080; font-weight: bold } /* Generic.Prompt */
.pyg-gs { font-weight: bold } /* Generic.Strong */
.pyg-gu { color: #800080; font-weight: bold } /* Generic.Subheading */
.pyg-gt { color: #0044DD } /* Generic.Traceback */
.pyg-kc { color: #008000; font-weight: bold } /* Keyword.Constant */
.pyg-kd { color: #008000; font-weight: bold } /* Keyword.Declaration */
.pyg-kn { color: #008000; font-weight: bold } /* Keyword.Namespace */
.pyg-kp { color: #008000 } /* Keyword.Pseudo */
.pyg-kr { color: #008000; font-weight: bold } /* Keyword.Reserved */
.pyg-kt { color: #B00040 } /* Keyword.Type */
.pyg-m { color: #666666 } /* Literal.Number */
.pyg-s { color: #BA2121 } /* Literal.String */
.pyg-na { color: #7D9029 } /* Name.Attribute */
.pyg-nb { color: #008000 } /* Name.Builtin */
.pyg-nc { color: #0000FF; font-weight: bold } /* Name.Class */
.pyg-no { color: #880000 } /* Name.Constant */
.pyg-nd { color: #AA22FF } /* Name.Decorator */
.pyg-ni { color: #999999; font-weight: bold } /* Name.Entity */
.pyg-ne { color: #D2413A; font-weight: bold } /* Name.Exception */
.pyg-nf { color: #0000FF } /* Name.Function */
.pyg-nl { color: #A0A000 } /* Name.Label */
.pyg-nn { color: #0000FF; font-weight: bold } /* Name.Namespace */
.pyg-nt { color: #008000; font-weight: bold } /* Name.Tag */
.pyg-nv { color: #19177C } /* Name.Variable */
.pyg-ow { color: #AA22FF; font-weight: bold } /* Operator.Word */
.pyg-w { color: #bbbbbb } /* Text.Whitespace */
.pyg-mb { color: #666666 } /* Literal.Number.Bin */
.pyg-mf { color: #666666 } /* Literal.Number.Float */
.pyg-mh { color: #666666 } /* Literal.Number.Hex */
.pyg-mi { color: #666666 } /* Literal.Number.Integer */
.pyg-mo { color: #666666 } /* Literal.Number.Oct */
.pyg-sa { color: #BA2121 } /* Literal.String.Affix */
.pyg-sb { color: #BA2121 } /* Literal.String.Backtick */
.pyg-sc { color: #BA2121 } /* Literal.String.Char */
.pyg-dl { color: #BA2121 } /* Literal.String.Delimiter */
.pyg-sd { color: #BA2121; font-style: italic } /* Literal.String.Doc */
.pyg-s2 { color: #BA2121 } /* Literal.String.Double */
.pyg-se { color: #BB6622; font-weight: bold } /* Literal.String.Escape */
.pyg-sh { color: #BA2121 } /* Literal.String.Heredoc */
.pyg-si { color: #BB6688; font-weight: bold } /* Literal.String.Interpol */
.pyg-sx { color: #008000 } /* Literal.String.Other */
.pyg-sr { color: #BB6688 } /* Literal.String.Regex */
.pyg-s1 { color: #BA2121 } /* Literal.String.Single */
.pyg-ss { color: #19177C } /* Literal.String.Symbol */
.pyg-bp { color: #008000 } /* Name.Builtin.Pseudo */
.pyg-fm { color: #0000FF } /* Name.Function.Magic */
.pyg-vc { color: #19177C } /* Name.Variable.Class */
.pyg-vg { color: #19177C } /* Name.Variable.Global */
.pyg-vi { color: #19177C } /* Name.Variable.Instance */
.pyg-vm { color: #19177C } /* Name.Variable.Magic */
.pyg-il { color: #666666 } /* Literal.Number.Integer.Long */
  </style>


    

    
  </head>

  <body>
    <div class="ui darkblue top fixed inverted menu" role="navigation" itemscope itemtype="http://www.schema.org/SiteNavigationElement" style="height: 40px; z-index: 1000;">
      <a class="ui header item " href="/" onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'topbar-home', transport: 'beacon'});" >rdrr.io<!-- <small>R Package Documentation</small>--></a>
      <a class='ui item ' href="/find/" itemprop="url" onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'topbar-find', transport: 'beacon'});" ><i class='search icon'></i><span itemprop="name">Find an R package</span></a>
      <a class='ui item ' href="/r/" itemprop="url" onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'topbar-rdoc', transport: 'beacon'});" ><i class='file text outline icon'></i> <span itemprop="name">R language docs</span></a>
      <a class='ui item ' href="/snippets/" itemprop="url" onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'topbar-snippets', transport: 'beacon'});" ><i class='play icon'></i> <span itemprop="name">Run R in your browser</span></a>

      <div class='right menu'>
        <form class='item' method='GET' action='/search'>
          <div class='ui right action input'>
            <input type='text' placeholder='packages, doc text, code...' size='24' name='q'>
            <button type="submit" class="ui green icon button"><i class='search icon'></i></button>
          </div>
        </form>
      </div>
    </div>

    
  




<div style='width: 280px; top: 24px; position: absolute;' class='ui vertical menu only-desktop bg-grey'>
  <a class='header  item' href='/cran/bnlearn/' style='padding-bottom: 4px' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-pkg-head', transport: 'beacon'});" >
    <h3 class='ui header' style='margin-bottom: 4px'>
      bnlearn
      <div class='sub header'>Bayesian Network Structure Learning, Parameter Learning and Inference</div>
    </h3>
    <small style='padding: 0 0 16px 0px' class='fakelink'>Package index</small>
  </a>

  <form class='item' method='GET' action='/search'>
    <div class='sub header' style='margin-bottom: 4px'>Search the bnlearn package</div>
    <div class='ui action input' style='padding-right: 32px'>
      <input type='hidden' name='package' value='bnlearn'>
      <input type='hidden' name='repo' value='cran'>
      <input type='text' placeholder='' name='q'>
      <button type="submit" class="ui green icon button">
        <i class="search icon"></i>
      </button>
    </div>
  </form>

  
    <div class='header item' style='padding-bottom: 7px'>Vignettes</div>
    <small>
      <ul class='fakelist'>
        
          <li>
            <a href='/cran/bnlearn/man/bnlearn-package.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-imp', transport: 'beacon'});" >
              Package overview
              
            </a>
          </li>
        
      </ul>
    </small>
  

  
<div class='ui floating dropdown item finder '>
  <b><a href='/cran/bnlearn/api/' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-index', transport: 'beacon'});" >Functions</a></b> <div class='ui blue label'>861</div>
  <i class='caret right icon'></i>
  
  
  
</div>

  
<div class='ui floating dropdown item finder active'>
  <b><a href='/cran/bnlearn/f/' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-index', transport: 'beacon'});" >Source code</a></b> <div class='ui blue label'>113</div>
  <i class='caret right icon'></i>
  
  
  
</div>

  
<div class='ui floating dropdown item finder '>
  <b><a href='/cran/bnlearn/man/' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-index', transport: 'beacon'});" >Man pages</a></b> <div class='ui blue label'>69</div>
  <i class='caret right icon'></i>
  
    <small>
      <ul style='list-style-type: none; margin: 12px auto 0; line-height: 2.0; padding-left: 0px; padding-bottom: 8px;'>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/alarm.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>alarm: </b>ALARM monitoring system (synthetic) data set</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/alpha.star.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>alpha.star: </b>Estimate the optimal imaginary sample size for BDe(u)</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/arcops.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>arcops: </b>Drop, add or set the direction of an arc or an edge</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/arc.strength.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>arc.strength: </b>Measure arc strength</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/asia.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>asia: </b>Asia (synthetic) data set by Lauritzen and Spiegelhalter</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/bayesian.network.classifiers.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>bayesian.network.classifiers: </b>Bayesian network Classifiers</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/bf.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>bf: </b>Bayes factor between two network structures</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/blacklist.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>blacklist: </b>Get or create whitelists and blacklists</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/bnboot.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>bnboot: </b>Nonparametric bootstrap of Bayesian networks</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/bn.class.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>bn.class: </b>The bn class structure</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/bn.cv.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>bn.cv: </b>Cross-validation for Bayesian networks</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/bn.fit.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>bn.fit: </b>Fit the parameters of a Bayesian network</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/bn.fit.class.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>bn.fit.class: </b>The bn.fit class structure</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/bn.fit.methods.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>bn.fit.methods: </b>Utilities to manipulate fitted Bayesian networks</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/bn.fit.plots.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>bn.fit.plots: </b>Plot fitted Bayesian networks</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/bn.kcv.class.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>bn.kcv.class: </b>The bn.kcv class structure</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/bnlearn-package.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>bnlearn-package: </b>Bayesian network structure learning, parameter learning and...</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/bn.strength-class.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>bn.strength-class: </b>The bn.strength class structure</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/ci.test.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>ci.test: </b>Independence and conditional independence tests</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/clgaussian-test.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>clgaussian-test: </b>Synthetic (mixed) data set to test learning algorithms</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/compare.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>compare: </b>Compare two or more different Bayesian networks</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/conditional.independence.tests.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>conditional.independence.tests: </b>Conditional independence tests</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/configs.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>configs: </b>Construct configurations of discrete variables</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/constraint.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>constraint: </b>Constraint-based structure learning algorithms</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/coronary.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>coronary: </b>Coronary heart disease data set</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/count.graphs.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>count.graphs: </b>Count graphs with specific characteristics</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/cpdag.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>cpdag: </b>Equivalence classes, moral graphs and consistent extensions</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/cpquery.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>cpquery: </b>Perform conditional probability queries</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/dsep.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>dsep: </b>Test d-separation</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/foreign.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>foreign: </b>Read and write BIF, NET, DSC and DOT files</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/gaussian-test.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>gaussian-test: </b>Synthetic (continuous) data set to test learning algorithms</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/gRain.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>gRain: </b>Import and export networks from the gRain package</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/graph.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>graph: </b>Utilities to manipulate graphs</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/graphgen.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>graphgen: </b>Generate empty or random graphs</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/graphpkg.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>graphpkg: </b>Import and export networks from the graph package</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/graphviz.chart.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>graphviz.chart: </b>Plotting networks with probability bars</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/graphviz.plot.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>graphviz.plot: </b>Advanced Bayesian network plots</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/hailfinder.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>hailfinder: </b>The HailFinder weather forecast system (synthetic) data set</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/hc.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>hc: </b>Score-based structure learning algorithms</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/hybrid.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>hybrid: </b>Hybrid structure learning algorithms</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/igraphpkg.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>igraphpkg: </b>Import and export networks from the igraph package</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/impute.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>impute: </b>Predict or impute missing data from a Bayesian network</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/insurance.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>insurance: </b>Insurance evaluation network (synthetic) data set</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/kl.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>kl: </b>Compute the distance between two fitted Bayesian networks</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/learn.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>learn: </b>Discover the structure around a single node</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/learning-test.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>learning-test: </b>Synthetic (discrete) data set to test learning algorithms</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/lizards.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>lizards: </b>Lizards&#39; perching behaviour data set</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/marks.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>marks: </b>Examination marks data set</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/mb.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>mb: </b>Miscellaneous utilities</a></li>
        
          <li style='white-space: nowrap; text-overflow: clip; overflow: hidden;'><a href='/cran/bnlearn/man/mi.matrix.html' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-finder-obj', transport: 'beacon'});" ><b>mi.matrix: </b>Local discovery structure learning algorithms</a></li>
        
        <li style='padding-top: 4px; padding-bottom: 0;'><a href='/cran/bnlearn/man/' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'sidebar-bottom-browse-all', transport: 'beacon'});" ><b>Browse all...</b></a></li>
      </ul>
    </small>
  
  
  
</div>


  

  
</div>



  <div class='desktop-pad' id='body-content'>
    <div class='ui fluid container bc-row'>
      <div class='ui breadcrumb' itemscope itemtype="http://schema.org/BreadcrumbList">
        <a class='section' href="/">Home</a>

        <div class='divider'> / </div>

        <span itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
          <a class='section' itemscope itemtype="http://schema.org/Thing" itemprop="item" id="https://rdrr.io/all/cran/" href="/all/cran/">
            <span itemprop="name">CRAN</span>
          </a>
          <meta itemprop="position" content="1" />
        </span>

        <div class='divider'> / </div>

        <span itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
          <a class='section' itemscope itemtype="http://schema.org/Thing" itemprop="item" id="https://rdrr.io/cran/bnlearn/" href="/cran/bnlearn/">
            <span itemprop="name">bnlearn</span>
          </a>
          <meta itemprop="position" content="2" />
        </span>

        <div class='divider'> / </div>

        <span itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem" class="active section">
          <a class='active section' itemscope itemtype="http://schema.org/Thing" itemprop="item" id="https://rdrr.io/cran/bnlearn/src/R/iamb-fdr.R" href="https://rdrr.io/cran/bnlearn/src/R/iamb-fdr.R">
            <span itemprop="name">R/iamb-fdr.R</span>
          </a>
          <meta itemprop="position" content="3" />
        </span>
      </div>
    </div>

    <div class="ui fluid container" style='padding: 0px 16px'>
      
        <div class='only-desktop' style='float: right; width: 300px; height: 600px;'><ins class="adsbygoogle"
style="display:block;min-width:120px;max-width:300px;width:100%;height:600px"
data-ad-client="ca-pub-6535703173049909"
data-ad-slot="9724778181"
data-ad-format="vertical"></ins></div>
      
      <h1 class='ui block header fit-content'>R/iamb-fdr.R
        <div class='sub header'>In <a href='/cran/bnlearn/'>bnlearn: Bayesian Network Structure Learning, Parameter Learning and Inference</a>
      </h1>

      
        <h4 class='ui header'>
          Defines functions 
          
            <a class='ui label' href='#sym-ia.detect.infinite.loop'>ia.detect.infinite.loop</a> 
          
            <a class='ui label' href='#sym-ia.fdr.markov.blanket'>ia.fdr.markov.blanket</a> 
          
            <a class='ui label' href='#sym-incremental.association.fdr'>incremental.association.fdr</a> 
          
        </h4>
      

      

      <div class="highlight"><pre style="word-wrap: break-word; white-space: pre-wrap;"><span></span><span class="pyg-n"><a id="sym-incremental.association.fdr" href="/cran/bnlearn/src/R/iamb-fdr.R">incremental.association.fdr</a></span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-function" class="mini-popup" href="/r/base/function.html" data-mini-url="/r/base/function.minihtml" >function</a></span><span class="pyg-p">(</span><span class="pyg-n">x</span><span class="pyg-p">,</span> <span class="pyg-n">cluster</span> <span class="pyg-o">=</span> <span class="pyg-kc"><a id="sym-NULL" class="mini-popup" href="/r/base/NULL.html" data-mini-url="/r/base/NULL.minihtml" >NULL</a></span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-whitelist" class="mini-popup" href="/cran/bnlearn/man/blacklist.html" data-mini-url="/cran/bnlearn/man/blacklist.minihtml" >whitelist</a></span><span class="pyg-p">,</span>
  <span class="pyg-n"><a id="sym-blacklist" class="mini-popup" href="/cran/bnlearn/man/blacklist.html" data-mini-url="/cran/bnlearn/man/blacklist.minihtml" >blacklist</a></span><span class="pyg-p">,</span> <span class="pyg-n">test</span><span class="pyg-p">,</span> <span class="pyg-n">alpha</span><span class="pyg-p">,</span> <span class="pyg-n">B</span><span class="pyg-p">,</span> <span class="pyg-n">max.sx</span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-ncol" class="mini-popup" href="/r/base/nrow.html" data-mini-url="/r/base/nrow.minihtml" >ncol</a></span><span class="pyg-p">(</span><span class="pyg-n">x</span><span class="pyg-p">),</span> <span class="pyg-n">complete</span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span> <span class="pyg-o">=</span> <span class="pyg-kc"><a id="sym-FALSE" class="mini-popup" href="/r/base/logical.html" data-mini-url="/r/base/logical.minihtml" >FALSE</a></span><span class="pyg-p">)</span> <span class="pyg-p">{</span>

  <span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-names" class="mini-popup" href="/r/base/names.html" data-mini-url="/r/base/names.minihtml" >names</a></span><span class="pyg-p">(</span><span class="pyg-n">x</span><span class="pyg-p">)</span>

  <span class="pyg-c1"># 1. [Compute Markov Blankets]</span>
  <span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-smartSapply" href="/cran/bnlearn/src/R/utils-cluster.R">smartSapply</a></span><span class="pyg-p">(</span><span class="pyg-n">cluster</span><span class="pyg-p">,</span> <span class="pyg-nf"><a id="sym-as.list" class="mini-popup" href="/r/base/list.html" data-mini-url="/r/base/list.minihtml" >as.list</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span><span class="pyg-p">),</span> <span class="pyg-n"><a id="sym-ia.fdr.markov.blanket" href="/cran/bnlearn/src/R/iamb-fdr.R">ia.fdr.markov.blanket</a></span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-data" class="mini-popup" href="/r/utils/data.html" data-mini-url="/r/utils/data.minihtml" >data</a></span> <span class="pyg-o">=</span> <span class="pyg-n">x</span><span class="pyg-p">,</span>
         <span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span><span class="pyg-p">,</span> <span class="pyg-n">alpha</span> <span class="pyg-o">=</span> <span class="pyg-n">alpha</span><span class="pyg-p">,</span> <span class="pyg-n">B</span> <span class="pyg-o">=</span> <span class="pyg-n">B</span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-whitelist" class="mini-popup" href="/cran/bnlearn/man/blacklist.html" data-mini-url="/cran/bnlearn/man/blacklist.minihtml" >whitelist</a></span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-whitelist" class="mini-popup" href="/cran/bnlearn/man/blacklist.html" data-mini-url="/cran/bnlearn/man/blacklist.minihtml" >whitelist</a></span><span class="pyg-p">,</span>
         <span class="pyg-n"><a id="sym-blacklist" class="mini-popup" href="/cran/bnlearn/man/blacklist.html" data-mini-url="/cran/bnlearn/man/blacklist.minihtml" >blacklist</a></span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-blacklist" class="mini-popup" href="/cran/bnlearn/man/blacklist.html" data-mini-url="/cran/bnlearn/man/blacklist.minihtml" >blacklist</a></span><span class="pyg-p">,</span> <span class="pyg-n">test</span> <span class="pyg-o">=</span> <span class="pyg-n">test</span><span class="pyg-p">,</span> <span class="pyg-n">max.sx</span> <span class="pyg-o">=</span> <span class="pyg-n">max.sx</span><span class="pyg-p">,</span>
         <span class="pyg-n">complete</span> <span class="pyg-o">=</span> <span class="pyg-n">complete</span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span><span class="pyg-p">)</span>
  <span class="pyg-nf"><a id="sym-names" class="mini-popup" href="/r/base/names.html" data-mini-url="/r/base/names.minihtml" >names</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">)</span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span>

  <span class="pyg-c1"># check markov blankets for consistency.</span>
  <span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-bn.recovery" href="/cran/bnlearn/src/R/backend-indep.R">bn.recovery</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span> <span class="pyg-o">=</span> <span class="pyg-kc"><a id="sym-TRUE" class="mini-popup" href="/r/base/logical.html" data-mini-url="/r/base/logical.minihtml" >TRUE</a></span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span><span class="pyg-p">)</span>

  <span class="pyg-c1"># 2. [Compute Graph Structure]</span>
  <span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-smartSapply" href="/cran/bnlearn/src/R/utils-cluster.R">smartSapply</a></span><span class="pyg-p">(</span><span class="pyg-n">cluster</span><span class="pyg-p">,</span> <span class="pyg-nf"><a id="sym-as.list" class="mini-popup" href="/r/base/list.html" data-mini-url="/r/base/list.minihtml" >as.list</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span><span class="pyg-p">),</span> <span class="pyg-n"><a id="sym-neighbour" href="/cran/bnlearn/src/R/backend-indep.R">neighbour</a></span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-data" class="mini-popup" href="/r/utils/data.html" data-mini-url="/r/utils/data.minihtml" >data</a></span> <span class="pyg-o">=</span> <span class="pyg-n">x</span><span class="pyg-p">,</span>
         <span class="pyg-n">alpha</span> <span class="pyg-o">=</span> <span class="pyg-n">alpha</span><span class="pyg-p">,</span> <span class="pyg-n">B</span> <span class="pyg-o">=</span> <span class="pyg-n">B</span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-whitelist" class="mini-popup" href="/cran/bnlearn/man/blacklist.html" data-mini-url="/cran/bnlearn/man/blacklist.minihtml" >whitelist</a></span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-whitelist" class="mini-popup" href="/cran/bnlearn/man/blacklist.html" data-mini-url="/cran/bnlearn/man/blacklist.minihtml" >whitelist</a></span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-blacklist" class="mini-popup" href="/cran/bnlearn/man/blacklist.html" data-mini-url="/cran/bnlearn/man/blacklist.minihtml" >blacklist</a></span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-blacklist" class="mini-popup" href="/cran/bnlearn/man/blacklist.html" data-mini-url="/cran/bnlearn/man/blacklist.minihtml" >blacklist</a></span><span class="pyg-p">,</span>
         <span class="pyg-n">test</span> <span class="pyg-o">=</span> <span class="pyg-n">test</span><span class="pyg-p">,</span> <span class="pyg-n">max.sx</span> <span class="pyg-o">=</span> <span class="pyg-n">max.sx</span><span class="pyg-p">,</span> <span class="pyg-n">complete</span> <span class="pyg-o">=</span> <span class="pyg-n">complete</span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span><span class="pyg-p">)</span>
  <span class="pyg-nf"><a id="sym-names" class="mini-popup" href="/r/base/names.html" data-mini-url="/r/base/names.minihtml" >names</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">)</span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span>

  <span class="pyg-c1"># check neighbourhood sets for consistency.</span>
  <span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-bn.recovery" href="/cran/bnlearn/src/R/backend-indep.R">bn.recovery</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span><span class="pyg-p">)</span>

  <span class="pyg-nf"><a id="sym-return" class="mini-popup" href="/r/base/function.html" data-mini-url="/r/base/function.minihtml" >return</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">)</span>

<span class="pyg-p">}</span><span class="pyg-c1">#INCREMENTAL.ASSOCIATION.FDR</span>

<span class="pyg-n"><a id="sym-ia.fdr.markov.blanket" href="/cran/bnlearn/src/R/iamb-fdr.R">ia.fdr.markov.blanket</a></span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-function" class="mini-popup" href="/r/base/function.html" data-mini-url="/r/base/function.minihtml" >function</a></span><span class="pyg-p">(</span><span class="pyg-n">x</span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-data" class="mini-popup" href="/r/utils/data.html" data-mini-url="/r/utils/data.minihtml" >data</a></span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span><span class="pyg-p">,</span> <span class="pyg-n">alpha</span><span class="pyg-p">,</span> <span class="pyg-n">B</span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-whitelist" class="mini-popup" href="/cran/bnlearn/man/blacklist.html" data-mini-url="/cran/bnlearn/man/blacklist.minihtml" >whitelist</a></span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-blacklist" class="mini-popup" href="/cran/bnlearn/man/blacklist.html" data-mini-url="/cran/bnlearn/man/blacklist.minihtml" >blacklist</a></span><span class="pyg-p">,</span>
  <span class="pyg-n"><a id="sym-start" class="mini-popup" href="/r/stats/start.html" data-mini-url="/r/stats/start.minihtml" >start</a></span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-character" class="mini-popup" href="/r/base/character.html" data-mini-url="/r/base/character.minihtml" >character</a></span><span class="pyg-p">(</span><span class="pyg-m">0</span><span class="pyg-p">),</span> <span class="pyg-n">test</span><span class="pyg-p">,</span> <span class="pyg-n">max.sx</span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-ncol" class="mini-popup" href="/r/base/nrow.html" data-mini-url="/r/base/nrow.minihtml" >ncol</a></span><span class="pyg-p">(</span><span class="pyg-n">x</span><span class="pyg-p">),</span> <span class="pyg-n">complete</span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span> <span class="pyg-o">=</span> <span class="pyg-kc"><a id="sym-FALSE" class="mini-popup" href="/r/base/logical.html" data-mini-url="/r/base/logical.minihtml" >FALSE</a></span><span class="pyg-p">)</span> <span class="pyg-p">{</span>

  <span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a>[nodes</span> <span class="pyg-o">!=</span> <span class="pyg-n">x]</span>
  <span class="pyg-n">fdr.threshold</span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-length" class="mini-popup" href="/r/base/length.html" data-mini-url="/r/base/length.minihtml" >length</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span><span class="pyg-p">)</span> <span class="pyg-o">/</span> <span class="pyg-nf"><a id="sym-seq_along" class="mini-popup" href="/r/base/seq.html" data-mini-url="/r/base/seq.minihtml" >seq_along</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span><span class="pyg-p">)</span> <span class="pyg-o">*</span> <span class="pyg-nf"><a id="sym-sum" class="mini-popup" href="/r/base/sum.html" data-mini-url="/r/base/sum.minihtml" >sum</a></span><span class="pyg-p">(</span><span class="pyg-m">1</span> <span class="pyg-o">/</span> <span class="pyg-nf"><a id="sym-seq_along" class="mini-popup" href="/r/base/seq.html" data-mini-url="/r/base/seq.minihtml" >seq_along</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span><span class="pyg-p">))</span>
  <span class="pyg-n">culprit</span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-character" class="mini-popup" href="/r/base/character.html" data-mini-url="/r/base/character.minihtml" >character</a></span><span class="pyg-p">(</span><span class="pyg-m">0</span><span class="pyg-p">)</span>
  <span class="pyg-n">whitelisted</span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span><span class="pyg-nf">[sapply</span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span><span class="pyg-p">,</span>
          <span class="pyg-nf"><a id="sym-function" class="mini-popup" href="/r/base/function.html" data-mini-url="/r/base/function.minihtml" >function</a></span><span class="pyg-p">(</span><span class="pyg-n">y</span><span class="pyg-p">)</span> <span class="pyg-p">{</span> <span class="pyg-nf">is.whitelisted</span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-whitelist" class="mini-popup" href="/cran/bnlearn/man/blacklist.html" data-mini-url="/cran/bnlearn/man/blacklist.minihtml" >whitelist</a></span><span class="pyg-p">,</span> <span class="pyg-nf"><a id="sym-c" class="mini-popup" href="/r/base/c.html" data-mini-url="/r/base/c.minihtml" >c</a></span><span class="pyg-p">(</span><span class="pyg-n">x</span><span class="pyg-p">,</span> <span class="pyg-n">y</span><span class="pyg-p">),</span> <span class="pyg-n">either</span> <span class="pyg-o">=</span> <span class="pyg-kc"><a id="sym-TRUE" class="mini-popup" href="/r/base/logical.html" data-mini-url="/r/base/logical.minihtml" >TRUE</a></span><span class="pyg-p">)</span> <span class="pyg-p">})</span><span class="pyg-n">]</span>
  <span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-start" class="mini-popup" href="/r/stats/start.html" data-mini-url="/r/stats/start.minihtml" >start</a></span>
  <span class="pyg-n">loop.counter</span> <span class="pyg-o">=</span> <span class="pyg-m">0</span>
  <span class="pyg-n"><a id="sym-state" class="mini-popup" href="/r/datasets/state.html" data-mini-url="/r/datasets/state.minihtml" >state</a></span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-vector" class="mini-popup" href="/r/base/vector.html" data-mini-url="/r/base/vector.minihtml" >vector</a></span><span class="pyg-p">(</span><span class="pyg-m">5</span> <span class="pyg-o">*</span> <span class="pyg-nf"><a id="sym-length" class="mini-popup" href="/r/base/length.html" data-mini-url="/r/base/length.minihtml" >length</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span><span class="pyg-p">),</span> <span class="pyg-n"><a id="sym-mode" class="mini-popup" href="/r/base/mode.html" data-mini-url="/r/base/mode.minihtml" >mode</a></span> <span class="pyg-o">=</span> <span class="pyg-s">&quot;list&quot;</span><span class="pyg-p">)</span>
  <span class="pyg-n">last.added</span> <span class="pyg-o">=</span> <span class="pyg-n">last.removed</span> <span class="pyg-o">=</span> <span class="pyg-kc"><a id="sym-NULL" class="mini-popup" href="/r/base/NULL.html" data-mini-url="/r/base/NULL.minihtml" >NULL</a></span>

  <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span><span class="pyg-p">)</span> <span class="pyg-p">{</span>

    <span class="pyg-nf"><a id="sym-cat" class="mini-popup" href="/r/base/cat.html" data-mini-url="/r/base/cat.minihtml" >cat</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;----------------------------------------------------------------\n&quot;</span><span class="pyg-p">)</span>
    <span class="pyg-nf"><a id="sym-cat" class="mini-popup" href="/r/base/cat.html" data-mini-url="/r/base/cat.minihtml" >cat</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;* learning the markov blanket of&quot;</span><span class="pyg-p">,</span> <span class="pyg-n">x</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;.\n&quot;</span><span class="pyg-p">)</span>

    <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-nf"><a id="sym-length" class="mini-popup" href="/r/base/length.html" data-mini-url="/r/base/length.minihtml" >length</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-start" class="mini-popup" href="/r/stats/start.html" data-mini-url="/r/stats/start.minihtml" >start</a></span><span class="pyg-p">)</span> <span class="pyg-o">&gt;</span> <span class="pyg-m">0</span><span class="pyg-p">)</span>
     <span class="pyg-nf"><a id="sym-cat" class="mini-popup" href="/r/base/cat.html" data-mini-url="/r/base/cat.minihtml" >cat</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;* initial set includes &#39;&quot;</span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-s">&quot;&#39;.\n&quot;</span><span class="pyg-p">)</span>

  <span class="pyg-p">}</span><span class="pyg-c1">#THEN</span>

  <span class="pyg-c1"># whitelisted nodes are included by default (if there&#39;s a direct arc</span>
  <span class="pyg-c1"># between them of course they are in each other&#39;s markov blanket).</span>
  <span class="pyg-c1"># arc direction is irrelevant here.</span>
  <span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-union" class="mini-popup" href="/r/base/sets.html" data-mini-url="/r/base/sets.minihtml" >union</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-n">whitelisted</span><span class="pyg-p">)</span>
  <span class="pyg-c1"># blacklist is not checked, not all nodes in a markov blanket must be</span>
  <span class="pyg-c1"># neighbours.</span>

  <span class="pyg-n"><a id="sym-repeat" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml" >repeat</a></span> <span class="pyg-p">{</span>

    <span class="pyg-c1"># stop when reaching the maximum size of the conditioning set.</span>
    <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-nf"><a id="sym-length" class="mini-popup" href="/r/base/length.html" data-mini-url="/r/base/length.minihtml" >length</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">)</span> <span class="pyg-o">&gt;</span> <span class="pyg-n">max.sx</span><span class="pyg-p">)</span> <span class="pyg-p">{</span>

       <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span><span class="pyg-p">)</span>
         <span class="pyg-nf"><a id="sym-cat" class="mini-popup" href="/r/base/cat.html" data-mini-url="/r/base/cat.minihtml" >cat</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;  @ limiting conditioning sets to&quot;</span><span class="pyg-p">,</span> <span class="pyg-n">max.sx</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;nodes.\n&quot;</span><span class="pyg-p">)</span>

      <span class="pyg-n"><a id="sym-break" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml" >break</a></span>

    <span class="pyg-p">}</span><span class="pyg-c1">#THEN</span>

    <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-nf"><a id="sym-ia.detect.infinite.loop" href="/cran/bnlearn/src/R/iamb-fdr.R">ia.detect.infinite.loop</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-state" class="mini-popup" href="/r/datasets/state.html" data-mini-url="/r/datasets/state.minihtml" >state</a></span><span class="pyg-p">,</span> <span class="pyg-n">loop.counter</span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span><span class="pyg-p">))</span> <span class="pyg-p">{</span>

      <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-o">!</span><span class="pyg-nf"><a id="sym-is.null" class="mini-popup" href="/r/base/NULL.html" data-mini-url="/r/base/NULL.minihtml" >is.null</a></span><span class="pyg-p">(</span><span class="pyg-n">last.removed</span><span class="pyg-p">))</span> <span class="pyg-p">{</span>

         <span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-c" class="mini-popup" href="/r/base/c.html" data-mini-url="/r/base/c.minihtml" >c</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-n">last.removed</span><span class="pyg-p">)</span>
         <span class="pyg-n">culprit</span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-c" class="mini-popup" href="/r/base/c.html" data-mini-url="/r/base/c.minihtml" >c</a></span><span class="pyg-p">(</span><span class="pyg-n">culprit</span><span class="pyg-p">,</span> <span class="pyg-n">last.removed</span><span class="pyg-p">)</span>

      <span class="pyg-p">}</span><span class="pyg-c1">#THEN</span>
      <span class="pyg-n"><a id="sym-else" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml" >else</a></span> <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-o">!</span><span class="pyg-nf"><a id="sym-is.null" class="mini-popup" href="/r/base/NULL.html" data-mini-url="/r/base/NULL.minihtml" >is.null</a></span><span class="pyg-p">(</span><span class="pyg-n">last.added</span><span class="pyg-p">))</span> <span class="pyg-p">{</span>

        <span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-setdiff" class="mini-popup" href="/r/base/sets.html" data-mini-url="/r/base/sets.minihtml" >setdiff</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-n">last.added</span><span class="pyg-p">)</span>
        <span class="pyg-n">culprit</span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-c" class="mini-popup" href="/r/base/c.html" data-mini-url="/r/base/c.minihtml" >c</a></span><span class="pyg-p">(</span><span class="pyg-n">culprit</span><span class="pyg-p">,</span> <span class="pyg-n">last.added</span><span class="pyg-p">)</span>

      <span class="pyg-p">}</span><span class="pyg-c1">#ELSE</span>

      <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span><span class="pyg-p">)</span>
        <span class="pyg-nf"><a id="sym-cat" class="mini-popup" href="/r/base/cat.html" data-mini-url="/r/base/cat.minihtml" >cat</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;  ! ignoring nodes &#39;&quot;</span><span class="pyg-p">,</span> <span class="pyg-n">culprit</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;&#39; from now on.\n&quot;</span><span class="pyg-p">)</span>

      <span class="pyg-c1"># reset the state list so that no further errors are raised.</span>
      <span class="pyg-n"><a id="sym-state" class="mini-popup" href="/r/datasets/state.html" data-mini-url="/r/datasets/state.minihtml" >state</a><a id="sym-[" class="mini-popup" href="/r/base/Extract.html" data-mini-url="/r/base/Extract.minihtml" >[</a>[loop.counter]]</span> <span class="pyg-o">=</span> <span class="pyg-kc"><a id="sym-NULL" class="mini-popup" href="/r/base/NULL.html" data-mini-url="/r/base/NULL.minihtml" >NULL</a></span>
      <span class="pyg-c1"># reset the loop counter to match.</span>
      <span class="pyg-n">loop.counter</span> <span class="pyg-o">=</span> <span class="pyg-n">loop.counter</span> <span class="pyg-o">-</span> <span class="pyg-m">1</span>

      <span class="pyg-nf"><a id="sym-warning" class="mini-popup" href="/r/base/warning.html" data-mini-url="/r/base/warning.minihtml" >warning</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;prevented infinite loop in Markov blanket learning (node &#39;&quot;</span><span class="pyg-p">,</span> <span class="pyg-n">x</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;&#39;).&quot;</span><span class="pyg-p">)</span>

    <span class="pyg-p">}</span><span class="pyg-c1">#THEN</span>

    <span class="pyg-c1"># increment the loop counter.</span>
    <span class="pyg-n">loop.counter</span> <span class="pyg-o">=</span> <span class="pyg-n">loop.counter</span> <span class="pyg-o">+</span> <span class="pyg-m">1</span>

    <span class="pyg-c1"># save the current markov blanket to detect changes and avoid infinite loops.</span>
    <span class="pyg-n"><a id="sym-state" class="mini-popup" href="/r/datasets/state.html" data-mini-url="/r/datasets/state.minihtml" >state</a><a id="sym-[" class="mini-popup" href="/r/base/Extract.html" data-mini-url="/r/base/Extract.minihtml" >[</a>[loop.counter]]</span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span>

    <span class="pyg-c1"># get an association measure for each of the available nodes.</span>
    <span class="pyg-n">association</span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-sapply" class="mini-popup" href="/r/base/lapply.html" data-mini-url="/r/base/lapply.minihtml" >sapply</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span><span class="pyg-p">,</span> <span class="pyg-nf"><a id="sym-function" class="mini-popup" href="/r/base/function.html" data-mini-url="/r/base/function.minihtml" >function</a></span><span class="pyg-p">(</span><span class="pyg-n">node</span><span class="pyg-p">)</span> <span class="pyg-p">{</span>
       <span class="pyg-nf"><a id="sym-indep.test" href="/cran/bnlearn/src/R/test.R">indep.test</a></span><span class="pyg-p">(</span><span class="pyg-n">x</span><span class="pyg-p">,</span> <span class="pyg-n">node</span><span class="pyg-p">,</span> <span class="pyg-n">sx</span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-setdiff" class="mini-popup" href="/r/base/sets.html" data-mini-url="/r/base/sets.minihtml" >setdiff</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-n">node</span><span class="pyg-p">),</span> <span class="pyg-n"><a id="sym-data" class="mini-popup" href="/r/utils/data.html" data-mini-url="/r/utils/data.minihtml" >data</a></span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-data" class="mini-popup" href="/r/utils/data.html" data-mini-url="/r/utils/data.minihtml" >data</a></span><span class="pyg-p">,</span> <span class="pyg-n">test</span> <span class="pyg-o">=</span> <span class="pyg-n">test</span><span class="pyg-p">,</span>
                        <span class="pyg-n">B</span> <span class="pyg-o">=</span> <span class="pyg-n">B</span><span class="pyg-p">,</span> <span class="pyg-n">alpha</span> <span class="pyg-o">=</span> <span class="pyg-n">alpha</span><span class="pyg-p">,</span> <span class="pyg-n">complete</span> <span class="pyg-o">=</span> <span class="pyg-n">complete</span><span class="pyg-p">)})</span>
    <span class="pyg-nf"><a id="sym-names" class="mini-popup" href="/r/base/names.html" data-mini-url="/r/base/names.minihtml" >names</a></span><span class="pyg-p">(</span><span class="pyg-n">association</span><span class="pyg-p">)</span> <span class="pyg-o">=</span> <span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span>

    <span class="pyg-c1"># sort the p-values and the FDR thresholds.</span>
    <span class="pyg-n">association</span> <span class="pyg-o">=</span> <span class="pyg-n">association</span><span class="pyg-nf">[order</span><span class="pyg-p">(</span><span class="pyg-n">association</span><span class="pyg-p">)</span><span class="pyg-n">]</span>
    <span class="pyg-nf"><a id="sym-names" class="mini-popup" href="/r/base/names.html" data-mini-url="/r/base/names.minihtml" >names</a></span><span class="pyg-p">(</span><span class="pyg-n">fdr.threshold</span><span class="pyg-p">)</span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-names" class="mini-popup" href="/r/base/names.html" data-mini-url="/r/base/names.minihtml" >names</a></span><span class="pyg-p">(</span><span class="pyg-n">association</span><span class="pyg-p">)</span>

    <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span><span class="pyg-p">)</span> <span class="pyg-p">{</span>

      <span class="pyg-nf"><a id="sym-cat" class="mini-popup" href="/r/base/cat.html" data-mini-url="/r/base/cat.minihtml" >cat</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;  * computing and sorting p-values.\n&quot;</span><span class="pyg-p">)</span>
      <span class="pyg-nf"><a id="sym-sapply" class="mini-popup" href="/r/base/lapply.html" data-mini-url="/r/base/lapply.minihtml" >sapply</a></span><span class="pyg-p">(</span><span class="pyg-nf"><a id="sym-names" class="mini-popup" href="/r/base/names.html" data-mini-url="/r/base/names.minihtml" >names</a></span><span class="pyg-p">(</span><span class="pyg-n">association</span><span class="pyg-p">),</span>
        <span class="pyg-nf"><a id="sym-function" class="mini-popup" href="/r/base/function.html" data-mini-url="/r/base/function.minihtml" >function</a></span><span class="pyg-p">(</span><span class="pyg-n">x</span><span class="pyg-p">)</span> <span class="pyg-p">{</span>
          <span class="pyg-nf"><a id="sym-cat" class="mini-popup" href="/r/base/cat.html" data-mini-url="/r/base/cat.minihtml" >cat</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;    &gt;&quot;</span><span class="pyg-p">,</span> <span class="pyg-n">x</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;has p-value&quot;</span><span class="pyg-p">,</span> <span class="pyg-n">association[x]</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;with threshold&quot;</span><span class="pyg-p">,</span>
            <span class="pyg-n">alpha</span> <span class="pyg-o">/</span> <span class="pyg-n">fdr.threshold[x]</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;.\n&quot;</span><span class="pyg-p">)</span>
        <span class="pyg-p">})</span>

    <span class="pyg-p">}</span><span class="pyg-c1">#THEN</span>

    <span class="pyg-c1"># remove nodes from the markov blanket (excluding whitelisted nodes and the</span>
    <span class="pyg-c1"># node added in the last iteration) in order of increasing association.</span>
    <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span><span class="pyg-p">)</span>
      <span class="pyg-nf"><a id="sym-cat" class="mini-popup" href="/r/base/cat.html" data-mini-url="/r/base/cat.minihtml" >cat</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;  * checking nodes for exclusion.\n&quot;</span><span class="pyg-p">)</span>

    <span class="pyg-n">candidates</span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-setdiff" class="mini-popup" href="/r/base/sets.html" data-mini-url="/r/base/sets.minihtml" >setdiff</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-nf"><a id="sym-c" class="mini-popup" href="/r/base/c.html" data-mini-url="/r/base/c.minihtml" >c</a></span><span class="pyg-p">(</span><span class="pyg-n">whitelisted</span><span class="pyg-p">,</span> <span class="pyg-n">last.added</span><span class="pyg-p">,</span> <span class="pyg-n">culprit</span><span class="pyg-p">))</span>

    <span class="pyg-nf">for </span><span class="pyg-p">(</span><span class="pyg-n">node</span> <span class="pyg-n"><a id="sym-in" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml" >in</a></span> <span class="pyg-nf"><a id="sym-rev" class="mini-popup" href="/r/base/rev.html" data-mini-url="/r/base/rev.minihtml" >rev</a></span><span class="pyg-p">(</span><span class="pyg-nf"><a id="sym-intersect" class="mini-popup" href="/r/base/sets.html" data-mini-url="/r/base/sets.minihtml" >intersect</a></span><span class="pyg-p">(</span><span class="pyg-nf"><a id="sym-names" class="mini-popup" href="/r/base/names.html" data-mini-url="/r/base/names.minihtml" >names</a></span><span class="pyg-p">(</span><span class="pyg-n">association</span><span class="pyg-p">),</span> <span class="pyg-n">candidates</span><span class="pyg-p">)))</span> <span class="pyg-p">{</span>

      <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-n">association[node]</span> <span class="pyg-o">*</span> <span class="pyg-n">fdr.threshold[node]</span> <span class="pyg-o">&gt;</span> <span class="pyg-n">alpha</span><span class="pyg-p">)</span> <span class="pyg-p">{</span>

        <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span><span class="pyg-p">)</span>
          <span class="pyg-nf"><a id="sym-cat" class="mini-popup" href="/r/base/cat.html" data-mini-url="/r/base/cat.minihtml" >cat</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;    @&quot;</span><span class="pyg-p">,</span> <span class="pyg-n">node</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;removed from the markov blanket.\n&quot;</span><span class="pyg-p">)</span>

        <span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-setdiff" class="mini-popup" href="/r/base/sets.html" data-mini-url="/r/base/sets.minihtml" >setdiff</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-n">node</span><span class="pyg-p">)</span>
        <span class="pyg-n">last.added</span> <span class="pyg-o">=</span> <span class="pyg-kc"><a id="sym-NULL" class="mini-popup" href="/r/base/NULL.html" data-mini-url="/r/base/NULL.minihtml" >NULL</a></span>
        <span class="pyg-n">last.removed</span> <span class="pyg-o">=</span> <span class="pyg-n">node</span>
        <span class="pyg-n"><a id="sym-break" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml" >break</a></span>

      <span class="pyg-p">}</span><span class="pyg-c1">#THEN</span>
      <span class="pyg-n"><a id="sym-else" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml" >else</a></span> <span class="pyg-p">{</span>

        <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span><span class="pyg-p">)</span>
          <span class="pyg-nf"><a id="sym-cat" class="mini-popup" href="/r/base/cat.html" data-mini-url="/r/base/cat.minihtml" >cat</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;    &gt;&quot;</span><span class="pyg-p">,</span> <span class="pyg-n">node</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;remains in the markov blanket.\n&quot;</span><span class="pyg-p">)</span>

      <span class="pyg-p">}</span><span class="pyg-c1">#ELSE</span>

    <span class="pyg-p">}</span><span class="pyg-c1">#FOR</span>

    <span class="pyg-c1"># start again from the top if the markov blanket has changed.</span>
    <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-o">!</span><span class="pyg-nf"><a id="sym-identical" class="mini-popup" href="/r/base/identical.html" data-mini-url="/r/base/identical.minihtml" >identical</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-state" class="mini-popup" href="/r/datasets/state.html" data-mini-url="/r/datasets/state.minihtml" >state</a><a id="sym-[" class="mini-popup" href="/r/base/Extract.html" data-mini-url="/r/base/Extract.minihtml" >[</a>[loop.counter]]</span><span class="pyg-p">))</span>
      <span class="pyg-n"><a id="sym-next" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml" >next</a></span>

    <span class="pyg-c1"># add nodes to the markov blanket in order of decreasing association.</span>
    <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span><span class="pyg-p">)</span>
      <span class="pyg-nf"><a id="sym-cat" class="mini-popup" href="/r/base/cat.html" data-mini-url="/r/base/cat.minihtml" >cat</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;  * checking nodes for association.\n&quot;</span><span class="pyg-p">)</span>

    <span class="pyg-n">candidates</span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-setdiff" class="mini-popup" href="/r/base/sets.html" data-mini-url="/r/base/sets.minihtml" >setdiff</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-nodes" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >nodes</a></span><span class="pyg-p">,</span> <span class="pyg-nf"><a id="sym-c" class="mini-popup" href="/r/base/c.html" data-mini-url="/r/base/c.minihtml" >c</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-n">last.removed</span><span class="pyg-p">,</span> <span class="pyg-n">culprit</span><span class="pyg-p">))</span>

    <span class="pyg-nf">for </span><span class="pyg-p">(</span><span class="pyg-n">node</span> <span class="pyg-n"><a id="sym-in" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml" >in</a></span> <span class="pyg-nf"><a id="sym-intersect" class="mini-popup" href="/r/base/sets.html" data-mini-url="/r/base/sets.minihtml" >intersect</a></span><span class="pyg-p">(</span><span class="pyg-nf"><a id="sym-names" class="mini-popup" href="/r/base/names.html" data-mini-url="/r/base/names.minihtml" >names</a></span><span class="pyg-p">(</span><span class="pyg-n">association</span><span class="pyg-p">),</span> <span class="pyg-n">candidates</span><span class="pyg-p">))</span> <span class="pyg-p">{</span>

      <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-n">association[node]</span> <span class="pyg-o">*</span> <span class="pyg-n">fdr.threshold[node]</span> <span class="pyg-o">&lt;=</span> <span class="pyg-n">alpha</span><span class="pyg-p">)</span> <span class="pyg-p">{</span>

        <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span><span class="pyg-p">)</span>
         <span class="pyg-nf"><a id="sym-cat" class="mini-popup" href="/r/base/cat.html" data-mini-url="/r/base/cat.minihtml" >cat</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;    @&quot;</span><span class="pyg-p">,</span> <span class="pyg-n">node</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;added to the markov blanket.\n&quot;</span><span class="pyg-p">)</span>

        <span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-c" class="mini-popup" href="/r/base/c.html" data-mini-url="/r/base/c.minihtml" >c</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-n">node</span><span class="pyg-p">)</span>
        <span class="pyg-n">last.added</span> <span class="pyg-o">=</span> <span class="pyg-n">node</span>
        <span class="pyg-n">last.removed</span> <span class="pyg-o">=</span> <span class="pyg-kc"><a id="sym-NULL" class="mini-popup" href="/r/base/NULL.html" data-mini-url="/r/base/NULL.minihtml" >NULL</a></span>
        <span class="pyg-n"><a id="sym-break" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml" >break</a></span>

      <span class="pyg-p">}</span><span class="pyg-c1">#THEN</span>
      <span class="pyg-n"><a id="sym-else" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml" >else</a></span> <span class="pyg-p">{</span>

        <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span><span class="pyg-p">)</span>
         <span class="pyg-nf"><a id="sym-cat" class="mini-popup" href="/r/base/cat.html" data-mini-url="/r/base/cat.minihtml" >cat</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;    &gt;&quot;</span><span class="pyg-p">,</span> <span class="pyg-n">node</span><span class="pyg-p">,</span> <span class="pyg-s">&quot;not added to the markov blanket.\n&quot;</span><span class="pyg-p">)</span>

      <span class="pyg-p">}</span><span class="pyg-c1">#ELSE</span>

    <span class="pyg-p">}</span><span class="pyg-c1">#FOR</span>

    <span class="pyg-c1"># if the markov blanket is unchanged, learning is complete.</span>
    <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-nf"><a id="sym-identical" class="mini-popup" href="/r/base/identical.html" data-mini-url="/r/base/identical.minihtml" >identical</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-state" class="mini-popup" href="/r/datasets/state.html" data-mini-url="/r/datasets/state.minihtml" >state</a><a id="sym-[" class="mini-popup" href="/r/base/Extract.html" data-mini-url="/r/base/Extract.minihtml" >[</a>[loop.counter]]</span><span class="pyg-p">))</span>
      <span class="pyg-n"><a id="sym-break" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml" >break</a></span>

  <span class="pyg-p">}</span><span class="pyg-c1">#REPEAT</span>

  <span class="pyg-nf"><a id="sym-return" class="mini-popup" href="/r/base/function.html" data-mini-url="/r/base/function.minihtml" >return</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">)</span>

<span class="pyg-p">}</span><span class="pyg-c1">#IA.FDR.MARKOV.BLANKET</span>

<span class="pyg-n"><a id="sym-ia.detect.infinite.loop" href="/cran/bnlearn/src/R/iamb-fdr.R">ia.detect.infinite.loop</a></span> <span class="pyg-o">=</span> <span class="pyg-nf"><a id="sym-function" class="mini-popup" href="/r/base/function.html" data-mini-url="/r/base/function.minihtml" >function</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-state" class="mini-popup" href="/r/datasets/state.html" data-mini-url="/r/datasets/state.minihtml" >state</a></span><span class="pyg-p">,</span> <span class="pyg-n">loop.counter</span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span><span class="pyg-p">)</span> <span class="pyg-p">{</span>

  <span class="pyg-nf">for </span><span class="pyg-p">(</span><span class="pyg-n">prev.mb</span> <span class="pyg-n"><a id="sym-in" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml" >in</a></span> <span class="pyg-n"><a id="sym-state" class="mini-popup" href="/r/datasets/state.html" data-mini-url="/r/datasets/state.minihtml" >state</a></span><span class="pyg-nf">[seq_len</span><span class="pyg-p">(</span><span class="pyg-n">loop.counter</span><span class="pyg-p">)</span><span class="pyg-n">]</span><span class="pyg-p">)</span> <span class="pyg-p">{</span>

    <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-o">!</span><span class="pyg-nf"><a id="sym-setequal" class="mini-popup" href="/r/base/sets.html" data-mini-url="/r/base/sets.minihtml" >setequal</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-n">prev.mb</span><span class="pyg-p">))</span>
      <span class="pyg-n"><a id="sym-next" class="mini-popup" href="/r/base/Control.html" data-mini-url="/r/base/Control.minihtml" >next</a></span>

    <span class="pyg-nf">if </span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-debug" class="mini-popup" href="/r/base/debug.html" data-mini-url="/r/base/debug.minihtml" >debug</a></span><span class="pyg-p">)</span> <span class="pyg-p">{</span>

      <span class="pyg-nf"><a id="sym-cat" class="mini-popup" href="/r/base/cat.html" data-mini-url="/r/base/cat.minihtml" >cat</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;  ! recurring markov blanket configuration detected (&quot;</span><span class="pyg-p">,</span> <span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-s">&quot;).\n&quot;</span><span class="pyg-p">)</span>
      <span class="pyg-nf"><a id="sym-cat" class="mini-popup" href="/r/base/cat.html" data-mini-url="/r/base/cat.minihtml" >cat</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;  ! retracing the steps of the learning process:\n&quot;</span><span class="pyg-p">)</span>
      <span class="pyg-nf"><a id="sym-sapply" class="mini-popup" href="/r/base/lapply.html" data-mini-url="/r/base/lapply.minihtml" >sapply</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-state" class="mini-popup" href="/r/datasets/state.html" data-mini-url="/r/datasets/state.minihtml" >state</a></span><span class="pyg-nf">[seq</span><span class="pyg-p">(</span><span class="pyg-n">loop.counter</span><span class="pyg-p">)</span><span class="pyg-n">]</span><span class="pyg-p">,</span>
        <span class="pyg-nf"><a id="sym-function" class="mini-popup" href="/r/base/function.html" data-mini-url="/r/base/function.minihtml" >function</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-str" class="mini-popup" href="/r/utils/str.html" data-mini-url="/r/utils/str.minihtml" >str</a></span><span class="pyg-p">)</span> <span class="pyg-p">{</span>
          <span class="pyg-nf"><a id="sym-cat" class="mini-popup" href="/r/base/cat.html" data-mini-url="/r/base/cat.minihtml" >cat</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;    &gt;&quot;</span><span class="pyg-p">,</span> <span class="pyg-nf"><a id="sym-paste" class="mini-popup" href="/r/base/paste.html" data-mini-url="/r/base/paste.minihtml" >paste</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-str" class="mini-popup" href="/r/utils/str.html" data-mini-url="/r/utils/str.minihtml" >str</a></span><span class="pyg-p">,</span> <span class="pyg-n">collapse</span> <span class="pyg-o">=</span> <span class="pyg-s">&quot; &quot;</span><span class="pyg-p">),</span> <span class="pyg-s">&quot;\n&quot;</span><span class="pyg-p">)</span>
        <span class="pyg-p">})</span>
     <span class="pyg-nf"><a id="sym-cat" class="mini-popup" href="/r/base/cat.html" data-mini-url="/r/base/cat.minihtml" >cat</a></span><span class="pyg-p">(</span><span class="pyg-s">&quot;    &gt;&quot;</span><span class="pyg-p">,</span> <span class="pyg-nf"><a id="sym-paste" class="mini-popup" href="/r/base/paste.html" data-mini-url="/r/base/paste.minihtml" >paste</a></span><span class="pyg-p">(</span><span class="pyg-n"><a id="sym-mb" class="mini-popup" href="/cran/bnlearn/man/mb.html" data-mini-url="/cran/bnlearn/man/mb.minihtml" >mb</a></span><span class="pyg-p">,</span> <span class="pyg-n">collapse</span> <span class="pyg-o">=</span> <span class="pyg-s">&quot; &quot;</span><span class="pyg-p">),</span> <span class="pyg-s">&quot;\n&quot;</span><span class="pyg-p">)</span>

    <span class="pyg-p">}</span><span class="pyg-c1">#THEN</span>

    <span class="pyg-nf"><a id="sym-return" class="mini-popup" href="/r/base/function.html" data-mini-url="/r/base/function.minihtml" >return</a></span><span class="pyg-p">(</span><span class="pyg-kc"><a id="sym-TRUE" class="mini-popup" href="/r/base/logical.html" data-mini-url="/r/base/logical.minihtml" >TRUE</a></span><span class="pyg-p">)</span>

  <span class="pyg-p">}</span><span class="pyg-c1">#FOR</span>

  <span class="pyg-nf"><a id="sym-return" class="mini-popup" href="/r/base/function.html" data-mini-url="/r/base/function.minihtml" >return</a></span><span class="pyg-p">(</span><span class="pyg-kc"><a id="sym-FALSE" class="mini-popup" href="/r/base/logical.html" data-mini-url="/r/base/logical.minihtml" >FALSE</a></span><span class="pyg-p">)</span>

<span class="pyg-p">}</span><span class="pyg-c1">#IA.FDR.DETECT.INFINITE.LOOP</span>
</pre></div>


      <div class='ui only-mobile fluid container' style='width: 320px; height: 100px;'><!-- rdrr-mobile-responsive -->
<ins class="adsbygoogle"
    style="display:block"
    data-ad-client="ca-pub-6535703173049909"
    data-ad-slot="4915028187"
    data-ad-format="auto"></ins></div>

      
  <h2 class='ui header'>Try the <a href="/cran/bnlearn/">bnlearn</a> package in your browser</h2>

  <div class='ui form'>
    <div class='field'>
      <textarea class="mousetrap snip-input" id="snip" rows='10' cols='80' style='width: 100%; font-size: 13px; font-family: Menlo,Monaco,Consolas,"Courier New",monospace !important' data-tag='snrub'>library(bnlearn)

help(ia.detect.infinite.loop)</textarea>
    </div>
  </div>

  <div class='ui container'>
    <div class='column'>
      <button class='ui huge green fluid button snip-run' data-tag='snrub' type="button" id="run">Run</button>
    </div>
    <div class='column'>
      <p><strong>Any scripts or data that you put into this service are public.</strong></p>
    </div>

    <div class='ui icon warning message snip-spinner hidden' data-tag='snrub'>
      <i class='notched circle loading icon'></i>
      <div class='content'>
        <div class='header snip-status' data-tag='snrub'>Nothing</div>
      </div>
    </div>

    <pre class='highlight hidden snip-output' data-tag='snrub'></pre>
    <div class='snip-images hidden' data-tag='snrub'></div>
  </div>


      <small><a href="/cran/bnlearn/">bnlearn documentation</a> built on Sept. 22, 2022, 1:08 a.m.</small>

    </div>
    
    

<div class="ui inverted darkblue vertical footer segment" style='margin-top: 16px; padding: 32px;'>
  <div class="ui center aligned container">
    <div class="ui stackable inverted divided three column centered grid">
      <div class="five wide column">
        <h4 class="ui inverted header">R Package Documentation</h4>
        <div class='ui inverted link list'>
          <a class='item' href='/' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'footer-home', transport: 'beacon'});" >rdrr.io home</a>
          <a class='item' href='/r/' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'footer-rdoc', transport: 'beacon'});" >R language documentation</a>
          <a class='item' href='/snippets/' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'footer-snippets', transport: 'beacon'});" >Run R code online</a>
        </div>
      </div>
      <div class="five wide column">
        <h4 class="ui inverted header">Browse R Packages</h4>
        <div class='ui inverted link list'>
          <a class='item' href='/all/cran/' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'footer-browse-cran', transport: 'beacon'});" >CRAN packages</a>
          <a class='item' href='/all/bioc/' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'footer-browse-bioc', transport: 'beacon'});" >Bioconductor packages</a>
          <a class='item' href='/all/rforge/' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'footer-browse-rforge', transport: 'beacon'});" >R-Forge packages</a>
          <a class='item' href='/all/github/' onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'footer-browse-github', transport: 'beacon'});" >GitHub packages</a>
        </div>
      </div>
      <div class="five wide column">
        <h4 class="ui inverted header">We want your feedback!</h4>
        <small>Note that we can't provide technical support on individual packages. You should contact the package authors for that.</small>
        <div class='ui inverted link list'>
          <a class='item' href="https://twitter.com/intent/tweet?screen_name=rdrrHQ" onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'footer-twitter', transport: 'beacon'});" >
            <div class='ui large icon label twitter-button-colour'>
              <i class='whiteish twitter icon'></i> Tweet to @rdrrHQ
            </div>
          </a>

          <a class='item' href="https://github.com/rdrr-io/rdrr-issues/issues" onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'footer-issues', transport: 'beacon'});" >
            <div class='ui large icon label github-button-colour'>
              <i class='whiteish github icon'></i> GitHub issue tracker
            </div>
          </a>

          <a class='item' href="mailto:ian@mutexlabs.com" onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'footer-email', transport: 'beacon'});" >
            <div class='ui teal large icon label'>
              <i class='whiteish mail outline icon'></i> ian@mutexlabs.com
            </div>
          </a>

          <a class='item' href="https://ianhowson.com" onclick="ga('send', 'event', {eventCategory: 'click', eventAction: 'footer-blog', transport: 'beacon'});" >
            <div class='ui inverted large image label'>
              <img class='ui avatar image' src='/static/images/ianhowson32.png'> <span class='whiteish'>Personal blog</span>
            </div>
          </a>
        </div>
      </div>
    </div>
  </div>

  
  <br />
  <div class='only-mobile' style='min-height: 120px'>
    &nbsp;
  </div>
</div>

  </div>


    <!-- suggestions button -->
    <div style='position: fixed; bottom: 2%; right: 2%; z-index: 1000;'>
      <div class="ui raised segment surveyPopup" style='display:none'>
  <div class="ui large header">What can we improve?</div>

  <div class='content'>
    <div class="ui form">
      <div class="field">
        <button class='ui fluid button surveyReasonButton'>The page or its content looks wrong</button>
      </div>

      <div class="field">
        <button class='ui fluid button surveyReasonButton'>I can't find what I'm looking for</button>
      </div>

      <div class="field">
        <button class='ui fluid button surveyReasonButton'>I have a suggestion</button>
      </div>

      <div class="field">
        <button class='ui fluid button surveyReasonButton'>Other</button>
      </div>

      <div class="field">
        <label>Extra info (optional)</label>
        <textarea class='surveyText' rows='3' placeholder="Please enter more detail, if you like. Leave your email address if you'd like us to get in contact with you."></textarea>
      </div>

      <div class='ui error message surveyError' style='display: none'></div>

      <button class='ui large fluid green disabled button surveySubmitButton'>Submit</button>
    </div>
  </div>
</div>

      <button class='ui blue labeled icon button surveyButton only-desktop' style='display: none; float: right;'><i class="comment icon"></i> Improve this page</button>
      
    </div>

    
      <script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
    

    
  


    <div class="ui modal snippetsModal">
  <div class="header">
    Embedding an R snippet on your website
  </div>
  <div class="content">
    <div class="description">
      <p>Add the following code to your website.</p>

      <p>
        <textarea class='codearea snippetEmbedCode' rows='5' style="font-family: Consolas,Monaco,'Andale Mono',monospace;">REMOVE THIS</textarea>
        <button class='ui blue button copyButton' data-clipboard-target='.snippetEmbedCode'>Copy to clipboard</button>
      </p>

      <p>For more information on customizing the embed code, read <a href='/snippets/embedding/'>Embedding Snippets</a>.</p>
    </div>
  </div>
  <div class="actions">
    <div class="ui button">Close</div>
  </div>
</div>

    
    <script type="text/javascript" src="/static/CACHE/js/73d0b6f91493.js"></script>

    
    <script type="text/javascript" src="/static/CACHE/js/484b2a9a799d.js"></script>

    
    <script type="text/javascript" src="/static/CACHE/js/ff65b770942d.js"></script>

    
  

<script type="text/javascript">$(document).ready(function(){$('.snip-run').click(runClicked);var key='ctrl+enter';var txt=' (Ctrl-Enter)';if(navigator&&navigator.platform&&navigator.platform.startsWith&&navigator.platform.startsWith('Mac')){key='command+enter';txt=' (Cmd-Enter)';}
$('.snip-run').text('Run '+txt);Mousetrap.bind(key,function(e){if($('.snip-run').hasClass('disabled')){return;}
var faketarget=$('.snip-run')[0]
runClicked({currentTarget:faketarget});});});</script>



    
  
<link rel="stylesheet" href="/static/CACHE/css/e738a11ac285.css" type="text/css" />



    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans:400,400italic,600,600italic,800,800italic">
    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Oswald:400,300,700">
  </body>
</html>
