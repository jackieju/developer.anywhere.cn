if ENV['RAILS_ENV'] == "development"
$SETTINGS={
        :git_server=>"localhost",
        :repo_root=>"/var/mygithub",
        :workspace_root=>"./tmp/workspaces",
        :review_url=>"http://127.0.0.1:3002/app/submit",
        :post_summit_url=>"http://127.0.0.1:3002/index.html",
    }
else
    $SETTINGS={
            :git_server=>"localhost",
            :repo_root=>"/var/mygithub",
            :workspace_root=>"./tmp/workspaces",
            :review_url=>"http://10.58.113.181:3002/app/submit",
            :post_summit_url=>"http://10.58.113.181:3002/index.html",
        }
end
$FS_RT_ROOT = "/var/sa"
$FS_EXT_ROOT = "extension"
$FS_RT_EXT_ROOT = "#{$FS_RT_ROOT}/script/extroot"

    
