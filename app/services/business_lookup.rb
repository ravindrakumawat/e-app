class BusinessLookup
  attr_reader :response
  def initialize
  end 

  def suggest(biz)
    segment_url = 'https://autocomplete.clearbit.com/v1/companies'.freeze
    @response = connection(segment_url).get('suggest', {query: biz})
    response.success? ? JSON.parse(response.body) : false
  end

  def find(biz_domain)
    domain_url = "https://company.clearbit.com/v2/companies".freeze 
    @response = connection(domain_url).get('find', {domain: biz_domain})
    response.success? ? JSON.parse(response.body) : false
  end

  def lookup(domin)
    if res = find(domin)
      format_data(res)
    end
  end

  private

    def connection(url)
      conn = Faraday.new(url: url) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.basic_auth(ENV['CLEAR_BIT_KEY'], 'password')
      end
    end

    def format_data(business)
      {
        external_id: business['id'],
        name: business['name'],
        company_name: business['legalName'],
        domain: business['domain'],
        phone_number: business['phone'] || business['site']['phoneNumbers'][0],
        contact_email: business['site']['emailAddresses'][0],
        about: business['description'],
        founded_date: Date.new(business['foundedYear']),
        logo: business['logo'],
        address: [business['geo']['streetNumber'], business['geo']['streetName']].join(','),
        city: business['geo']['city'],
        state: business['geo']['state'],
        post_code: business['geo']['postalCode'],
        country: business['geo']['country'],
        no_of_employees: business['metrics']['employees']
      }
    end
end
