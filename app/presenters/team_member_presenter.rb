class TeamMemberPresenter < BasePresenter
  presents :team_member
  delegate :forename, :surname, :role, to: :team_member

  def full_name
    [forename, surname].join(' ')
  end
end
