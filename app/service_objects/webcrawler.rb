class Webcrawler
  attr_accessor :session, :responses

  def initialize
    super
    @session = Capybara::Session.new(:poltergeist)
    @responses = []
  end

  def perform gym_classes
    # Start crawling!
        enrol_in_classes current_user, jobs
      rescue => error
        raise error
      ensure
        sign_out
      end
    end

    def enrol_in_classes user, jobs
      go_to_website
      sign_in user
      jobs.each do |job|
        self.responses << try_enrol(job)
      end
      sign_out
      responses
    end

    def try_enrol job
      wait_for_javascript

      # Click on lesson
      find_lesson(job).click
      wait_for_javascript

      # Click confirm in modal popup
      confirm_lesson

      wait_for_slow_javascript

      # Get confirmation message
      modal_status = session.find('.modal-dialog').find('.bootstrap-dialog-title').text.downcase
      modal_message = session.find('.modal-dialog').find('.bootstrap-dialog-message').text

      # Dismiss modal
      session.find('.modal-dialog').find('.btn-default').click

      wait_for_javascript

      WebcrawlerResponse.new job: job, status: modal_status, message: modal_message
    end

    def go_to_website
      session.visit 'http://reservations.fightcitygym.com/'
    end

    def sign_in user = current_user
      session.click_link 'Login'
      session.fill_in 'email', with: user[:email]
      session.fill_in 'password', with: user[:password]
      session.click_button 'Login'
    end

    def sign_out safe: true;
      session.find('.dropdown-toggle').click if !safe || (safe && session.has_css?('.dropdown-toggle'))
      session.click_link 'Logout' if !safe || (safe && session.has_link?('Logout'))
    end

    def find_lesson job
      session.find('.fc-content-skeleton')
        .all('td')[job.day]
        .find("div[data-full='#{formatted_time(job.start_time)} - #{formatted_time(job.end_time)}']")
    end

    def confirm_lesson
      modal = session.find('.modal-dialog')
      modal.find('.btn-warning').click
    end

    private

      def current_user
        { email: "#{ENV['user_email']}", password: "#{ENV['user_password']}" }
      end

      def formatted_time time
        hour = time.split(':').first.to_i
        minute = time.split(':').last
        meridiem = hour >= 12 ? 'PM' : 'AM'
        hour = hour > 12 ? hour - 12 : hour
        "#{hour}:#{minute} #{meridiem}"
      end

      def wait_for_javascript
        sleep 0.5
      end

      def wait_for_slow_javascript
        sleep 10
      end
end
