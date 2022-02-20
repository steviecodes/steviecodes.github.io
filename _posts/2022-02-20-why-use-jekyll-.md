---
layout: post
title: Why use Jekyll?
date: 2022-02-20 00:53
categories: blogging jekyll go google s3 githubpages hosting
---

I am using [Jekyll](https://jekyllrb.com/) for my site/blog. Jekyll is a static site generator that creates a HTML site, with predictable page layouts and content with regular presentation such as blogs.

## Why use a static site generator?

Static site generators are appealing because they produce secure sites requiring
little maintenance that are faster to serve than dynamically generated web
pages. With dynamic web pages, a web framework installed on a server generates
the page a user sees. A user makes a request, the server queries a database,
pulls out the information users want to see, combines that data into an HTML
page, then sends that page to a user.

With static HTML pages, the pages are pre-rendered, so the server doesn’t do any
of the work of building the page. It only handles sending the appropriate page
to the user. This means that static HTML pages are faster, and the computing
requirements for the server are much smaller; important in cloud environments
where you’re charged for computing power.

Because static pages don’t require servers to perform calculations or query the
database, you can deploy them using very simple, low-cost hosting options like
an [Amazon S3
bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/HostingWebsiteOnS3Setup.html)
or [GitHub Pages](http://pages.github.com).

I could simply write a HTML page and put it on a server, heacing back to the
early days of the web, but static site generators make it much easier to create
new pages that use existing templates or modify all of your existing pages at
once.

There are many frameworks that can leverage a programming language and allow you
to reuse code and process assets for these HTML pages. When deciding what
framework to use I had two choices, [Hugo](https://gohugo.io/) and Jekyll.

##  Hugo vs. Jekyll

With either generator, you can get a templated blog/site up and running in under
thirty minutes. In both I write a content file like a blog post in HTML or
Markdown. Both frameworks allow me to add variables to content, using the YAML
markup language, and consume data files in common formats like JSON and CSV.
Both  also come with a number of features useful for a blog, like tags and the
ability to route content files to finished HTML pages. They are also open
source.

Jekyll is written in [Ruby](https://www.ruby-lang.com), a popular scripting
language that was one of the first languages to come with an opinionated web
framework, making it extremely popular for building websites quickly. Hugo is
written in [Go](https://go.dev), which was developed at
[Google](https://www.google.com) with an eye on concurrent execution, optimizing
for deployment in cloud environments where computing power is distributed across
many machines.

So far this has been a basic comparison. There are bigger ones under the hood
such as supporting markup types, templates, hosting and setup.

As stated before, both Hugo and Jekyll are well suited for blogs and other 
frontend sites.

##  Why did jekyll win?

Jekyll has the fastest setup, more options for templates, and offers an easier 
experience when getting started. This was of paramount importance to me. I 
want to get on with cooler development tasks. I want to start blogging straight
away. Hugo’s initial setup is more complicated and would be barrier to getting
started. Therefore Jekyll won.



