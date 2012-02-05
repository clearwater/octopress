This is the Octopress source for the Gaugette project blog.  You
probably don't really want to be here so much as you want to be
at [The Gaugette Blog](http://clearwater.github.com/gaugette).

Branching Octopress for a New Github Project Blog
=================================================

1.  git checkout master
2.  git checkout -b project-name
3.  git push -u octopress project-name
4.  rake install
5.  rake setup_github_pages  << this probably only works right the first time
6.  rake set_root_dir[/project-name/]
7.  rake new_post["First Post"]
8.  rake generate
9. rake deploy 
10.  git add sass source Rakefile _config.yml
11. git commit -m "First post"
12. git push

