class AppController < ApplicationController
    # used by internal
    def list
        p "====>select * from apps where uid=#{@user.id}"
        @apps = App.find_by_sql("select * from apps where uid=#{@user.id}")
    end
    
    def app
    end
    
    def query_app
        appid = params[:appid]
         rs = App.find_by_sql("select * from apps where appid='#{appid}'")
            if rs == nil || rs.size == 0
                error("No such App")
                return
            end
            app = rs[0]
            
        success("OK", app.attributes)
        return
    end
    def delapp
        repo = appid = params[:appid]
        
        if !repo || repo == ""
            error("invalid repository name")
            return
        end
        
        # r = system "cd #{$SETTINGS[:repo_root]}\n
        #        git init --bare #{repo}.git"
        
        # p "system call return #{r}"
        # 
        begin
            p "appid=>#{appid}"
            rs = ActiveRecord::Base.connection.execute("delete from apps where appid='#{appid}'")
        rescue Exception=>e
            error("delet app from db failed #{e.inspect}")
            return
        end
        
        begin
            p "===>delete file #{repo_ws_path(appid)}"
            FileUtils.rm_rf(repo_ws_path(appid))
        rescue Exception=>e
            error("delete app files failed #{e.inspect}")
            return
        end       
        success()
    end
    def createapp
        appid=params[:appid]
        name=params[:name]
        desc=params[:desc]
        
        begin
            p "appid=>#{appid}"
            App.new({
                :appid=>appid,
                :name=>name,
                :desc=>desc,
                :uid=>@user.id
            }).save!
        rescue Exception=>e
            error("create app failed #{e.inspect}")
            return
        end
        
        _create_repo(appid)
        
        # TODO preserv app id and name in pubapps
        
        success()
        
    end
    
    # create repo for one app
    def create_repo
        repo = params[:repo]
        
        if !repo || repo == ""
            error("invalid repository name")
            return
        end
        
        r = system "cd #{$SETTINGS[:repo_root]}\n
               git init --bare #{repo}.git
               chown -R git:git #{repo}.git"
        
        p "system call return #{r}"
        
        success('OK', {:ret=>r})
    end
    def _create_repo(repo)
        p "cd #{$SETTINGS[:repo_root]}\n
                git init --bare #{repo}.git"
                
        r = system "cd #{$SETTINGS[:repo_root]}\n
                git init --bare #{repo}.git"

        p "system call return #{r}"
         
    end
    
    def update
            appid=params[:appid]
            name=params[:name]
            desc=params[:desc]
            dt = params[:dt]

            begin
            p "appid=>#{appid}"
            rs = App.find_by_sql("select * from apps where appid='#{appid}'")
            if rs == nil || rs.size == 0
                error("Cannot find app")
                return
            else
                rs[0][:desc] = desc
                rs[0][:dt] = dt
                rs[0].save
            end
            rescue Exception=>e
                error("create app failed #{e.inspect}")
                return
            end
        success
        
    end
    
    def presubmit
        appid = params[:appid]
        rs = App.find_by_sql("select * from apps where appid='#{appid}'")
        
        if rs == nil || rs.size == 0
            render :text=>"cannot find app with id #{appid}"
            return
        end
        
        @app = rs[0]
        p "======>hello"
    end
    
    def aftersummit
        redirect_to "#{$SETTINGS[:post_summit_url]}?appid=#{params[:appid]}"
    end
end
