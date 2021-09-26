class BusinessSearch
  SEGMENT_URL = 'https://autocomplete.clearbit.com/v1/companies'.freeze
  DOMAIN_URL  = "https://company.clearbit.com/v2/companies".freeze
  
  attr_reader :response
  def initialize
  end 

  def find_by_query(query_str)
    @response = connection(SEGMENT_URL).get('suggest', {query: query_str})
    response.success? ? json_parse : false
  end

  def find_by_domain(domain_str)
    @response = connection(DOMAIN_URL).get('find', {domain: domain_str})
    response.success? ? json_parse : false
  end

  def search_by_domin(domin_str)
    if resp = find_by_domain(domin_str)
      business_params(resp)
    end
  end

  private

    def connection(url)
      Faraday.new(url: url) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.basic_auth(ENV['CLEAR_BIT_KEY'], 'p')
      end
    end

    def json_parse
      JSON.parse(response.body)
    end

    def business_params(resp)
      {
        external_id: resp['id'],
        name: resp['name'],
        company_name: resp['legalName'],
        domain: resp['domain'],
        time_zone: resp['timeZone'],
        phone_number: resp['phone'],
        about: resp['description'],
        founded_year: resp['foundedYear'],
        logo: resp['logo'],
        address: [resp['geo']['streetNumber'], resp['geo']['streetName']].join(','),
        city: resp['geo']['city'],
        state: resp['geo']['state'],
        post_code: resp['geo']['postalCode'],
        country: resp['geo']['country'],
        latitude: resp['lat'],
        longitude: resp['lng'],
        no_of_employees: resp['metrics']['employees'],
        contact_infos_attributes: parse_contacts(resp),
        social_accounts_attributes: parse_social_network(resp)
      }
    end

    def parse_contacts(data = {})
      (data['site']['phoneNumbers'] + Array.wrap(data['phone'])).compact.map{|phone| {contact_type: 'phone', contact: phone}} + 
      data['site']['emailAddresses'].compact.map{|email| {contact_type: 'email', contact: email}}
    end

    def parse_social_network(data = {})
      ['facebook','linkedin','twitter','crunchbase'].map do |network|
        network_data = data[network] || {}
        {social_network: network, handle: network_data['handle'], account_details: network_data}
      end
    end
end
