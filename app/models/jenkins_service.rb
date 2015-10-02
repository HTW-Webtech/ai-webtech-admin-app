# YAML:
# jenkins_jobs:
#   app-name:
#     url: http://app-name.webtech.info
#     exercise_id: 1
#     user_email: foo@bar.com
class JenkinsService
  def self.publish(app)
    @jobs = load_jobs
    add_or_update(@jobs, app)
    store_jobs(@jobs)
  end

  def self.load_jobs
    jobs_yml = IO.binread jenkins_jobs_yaml_path
    jobs = if jobs_yml.present?
      YAML.load(jobs_yml)
    else
      { 'jenkins_jobs': {} }
    end
    jobs['jenkins_jobs']
  end

  def self.store_jobs(jobs)
    jobs_yml = YAML.dump({ 'jenkins_jobs': jobs })
    IO.binwrite jenkins_jobs_yaml_path, jobs_yml
  end

  def self.add_or_update(jobs, app)
    job = jobs[app.name] || {}
    job['url'] = app.public_url
    job['exercise_id'] = app.exercise_id
    job['user_email']  = app.user.email
    jobs
  end

  def self.jenkins_jobs_yaml_path
    '/opt/aris/config/jenkins_jobs.yml'
  end
end
