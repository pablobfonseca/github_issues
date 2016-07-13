require '../github_issues'

describe GithubIssues do
  let(:response) { JSON.parse(File.open("./fixtures/response.json").read) }

  it 'should be a json response' do
    expect(response["url"]).to match(/github/)
  end

  context 'valid repository and organization' do
    describe 'closed issues' do
      it 'closed issues should not be zero' do
        api = described_class.new({org: "rails", repo: "rails", status: 'closed'})
        api.report_closed_issues
        expect(api.closed_issues[:issues].length).not_to eq 0
      end
    end

    describe 'opened issues' do
      it 'opened issues should not be zero' do
        api = described_class.new({org: "rails", repo: "rails", status: 'open'})
        api.report
        expect(api.opened_issues.length).not_to eq 0
      end
    end
  end
end
