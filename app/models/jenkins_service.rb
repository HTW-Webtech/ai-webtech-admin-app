# YAML:
# jenkins_jobs:
#   app-name:
#     url: http://app-name.webtech.com
#     exercise_id: 1
#     user_email: foo@bar.com
class JenkinsService
  def self.publish(app_or_apps)
    apps = Array(app_or_apps)
    jobs = load_jobs
    jobs = add_or_update(jobs, apps)
    store_jobs(jobs)
  end

  def self.load_jobs
    jobs_yml = read_jenkins_jobs_yaml
    jobs = if jobs_yml.present?
      YAML.load(jobs_yml)
    else
      { 'jenkins_jobs' => {} }
    end
    jobs['jenkins_jobs']
  end

  def self.read_jenkins_jobs_yaml
    IO.binread jenkins_jobs_yaml_path
    rescue Errno::ENOENT => e
  end

  def self.store_jobs(jobs)
    jobs_yml = YAML.dump({ 'jenkins_jobs' => jobs })
    IO.binwrite jenkins_jobs_yaml_path, jobs_yml
  end

  def self.add_or_update(jobs, apps)
    apps.each do |app|
      job = jobs[app.name] || {}
      job['exercise_base_url'] = app.public_url
      job['exercise_id'] = app.exercise_id
      job['user_name']   = app.user.name
      job['user_email']  = app.user.email
      jobs[app.name] = job
    end
    jobs
  end

  def self.jenkins_jobs_yaml_path
    '/opt/aris/config/jenkins_jobs.yml'
  end
end
