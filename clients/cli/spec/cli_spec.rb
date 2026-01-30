require "open3"
require "spec_helper"

RSpec.describe "General behavior" do
  let(:config) { <<~YAML }
    phrase:
      host: #{ENV.fetch("BASE_URL")}
      project_id: "test-project"
      access_token: "test-token"
  YAML

  it "info prints the version" do
    r = run_cli("info")
    expect(r[:exit_code]).to eq(0)
    expect(r[:stdout]).to include("Phrase Strings client version")
    expect(r[:stderr]).to include("You're running a development version")
  end

  describe "format commands" do
    before do
      mock_set!("GET", "/formats", status: 200, body: [
        {
          name: "Ruby/Rails YAML",
          api_name: "yml",
          description: "YAML file format for use with Ruby/Rails applications",
          extension: "yml",
          default_encoding: "UTF-8",
          importable: true,
          exportable: true,
          default_file: "./config/locales/<locale_name>.yml",
          renders_default_locale: false,
          includes_locale_information: true
        }
      ])
    end

    it "gets the format list" do
      r = run_cli("formats", "list", config:)
      expect(r[:exit_code]).to eq(0)
      expect(r[:stdout]).to include("Ruby/Rails YAML")

      requests_made = mock_requests
      expect(requests_made.length).to eq(1)

      request = requests_made.first
      expect(request["method"]).to eq("GET")
      expect(request["path"]).to eq("/formats")
      expect(request["headers"]["HTTP_AUTHORIZATION"]).to eq("token test-token")
    end
  end
end
