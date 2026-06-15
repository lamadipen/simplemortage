class TeamMember {
  const TeamMember({
    required this.name,
    required this.role,
    required this.imagePath,
    required this.bio,
    this.nmls,
    this.licensedStates,
    this.leadership = false,
  });

  final String name;
  final String role;
  final String imagePath;
  final String bio;
  final String? nmls;
  final String? licensedStates;
  final bool leadership;
}

const teamMembers = <TeamMember>[
  TeamMember(
    name: 'Ganesh Baniya',
    role: 'President & CEO / Mortgage Loan Officer',
    imagePath: 'assets/team/ganesh-baniya.jpg',
    nmls: 'NMLS 1623550',
    licensedStates: 'Licensed in CO, MD, NC, OH, PA & VA',
    leadership: true,
    bio:
        'With more than two decades of finance and accounting experience, '
        'Ganesh leads with transparency and a deeply personal approach to home '
        'financing. He is committed to making every client feel informed, '
        'supported, and confident from the first conversation through closing.',
  ),
  TeamMember(
    name: 'Dr. Arjun Banjade',
    role: 'Vice President / Mortgage Loan Officer',
    imagePath: 'assets/team/arjun-banjade.jpg',
    nmls: 'NMLS 2791679',
    licensedStates: 'Licensed in VA & MD',
    leadership: true,
    bio:
        'Dr. Banjade brings extensive knowledge of mortgage lending, loan '
        'structuring, and financial planning. His integrity, attention to '
        'detail, and client-first approach help borrowers move through home '
        'financing with clarity and confidence.',
  ),
  TeamMember(
    name: 'Binod Bastakoti',
    role: 'Business Development Manager',
    imagePath: 'assets/team/binod-bastakoti.jpg',
    bio:
        'Binod helps individuals, families, and investors navigate mortgage '
        'options with honest guidance. He focuses on tailored solutions, '
        'dependable service, and long-term client relationships.',
  ),
  TeamMember(
    name: 'Rajshree Shrestha',
    role: 'Operations Manager',
    imagePath: 'assets/team/rajshree-shrestha.jpg',
    bio:
        'Rajshree oversees day-to-day operations, cross-team coordination, and '
        'process improvement. Her work keeps the organization efficient, '
        'compliant, and focused on a consistent customer experience.',
  ),
  TeamMember(
    name: 'Kris Chetry',
    role: 'Loan Processing Manager',
    imagePath: 'assets/team/kris-chetry.jpg',
    bio:
        'Kris brings an organized, multilingual, and detail-oriented approach '
        'to loan processing. She coordinates documentation and communication '
        'carefully to help each transaction progress smoothly toward closing.',
  ),
  TeamMember(
    name: 'Min Datta Dhungana',
    role: 'Mortgage Loan Officer',
    imagePath: 'assets/team/min-datta-dhungana.jpg',
    nmls: 'NMLS 2224709',
    licensedStates: 'Licensed in VA & OH',
    bio:
        'With experience in banking and software engineering, Min combines '
        'financial knowledge with an analytical mindset. He simplifies the '
        'lending process and builds transparent solutions around each client.',
  ),
  TeamMember(
    name: 'Pradip Hayu',
    role: 'Mortgage Loan Officer',
    imagePath: 'assets/team/pradip-hayu.jpg',
    nmls: 'NMLS 2274179',
    licensedStates: 'Licensed in VA',
    bio:
        'Pradip combines a background in data analysis with the discipline and '
        'service values of a military veteran. He supports first-time buyers '
        'and experienced investors with precise, thoughtful guidance.',
  ),
  TeamMember(
    name: 'Keshab Bhatta',
    role: 'Mortgage Loan Officer',
    imagePath: 'assets/team/keshab-bhatta.jpg',
    nmls: 'NMLS 2490139',
    licensedStates: 'Licensed in VA',
    bio:
        'Keshab helps clients explore financing for primary homes, second '
        'homes, investment properties, and refinances. He emphasizes continuous '
        'communication from application through final funding.',
  ),
  TeamMember(
    name: 'Sudarshan Chapagain',
    role: 'VP / Mortgage Loan Originator',
    imagePath: 'assets/team/sudarshan-chapagain.jpg',
    nmls: 'NMLS 2570179',
    licensedStates: 'Licensed in CO',
    bio:
        'Sudarshan is a mortgage professional and CPA who brings deep finance, '
        'tax, and small-business knowledge to each conversation. His financial '
        'insight helps clients evaluate mortgage choices with confidence.',
  ),
  TeamMember(
    name: 'Kuber Bhandari',
    role: 'Loan Officer',
    imagePath: 'assets/team/kuber-bhandari.jpg',
    nmls: 'NMLS 2633463',
    licensedStates: 'Licensed in OH',
    bio:
        'Kuber blends real estate experience with more than a decade in senior '
        'IT roles. His analytical precision and people-first approach help make '
        'the loan process clear, personalized, and manageable.',
  ),
  TeamMember(
    name: 'Sachita Subedi',
    role: 'Mortgage Loan Officer',
    imagePath: 'assets/team/sachita-subedi.jpg',
    nmls: 'NMLS 2684951',
    licensedStates: 'Licensed in PA & DE',
    bio:
        'Sachita draws on more than a decade of CPA experience in finance and '
        'accounting to identify practical mortgage solutions. She keeps clients '
        'updated and supported throughout every stage of the application.',
  ),
  TeamMember(
    name: 'Durga Bhattarai',
    role: 'Loan Processor',
    imagePath: 'assets/team/durga-bhattarai.jpg',
    bio:
        'Durga has more than 15 years of experience coordinating detailed '
        'paperwork, records, teams, and client communication. Her organization '
        'and attention to detail keep loan files moving smoothly.',
  ),
];
