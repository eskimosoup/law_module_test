class TeamMemberPresenter < BasePresenter
  presents :team_member
  delegate :forename, :surname, :role, to: :team_member

  def full_name
    [forename, surname].join(' ')
  end

  def linked_google_plus(text = 'Google+', options = {})
    h.link_to text, team_member.google_plus, options if Flip.team_member_google_plus?
  end

  def linked_twitter(text = 'Follow me on Twitter', options = {})
    h.link_to text, team_member.twitter_link, options if Flip.team_member_twitter_link?
  end

  def linked_facebook(text = 'Add me on Facebook', options = {})
    h.link_to text, team_member.facebook_link, options if Flip.team_member_facebook_link?
  end
end
