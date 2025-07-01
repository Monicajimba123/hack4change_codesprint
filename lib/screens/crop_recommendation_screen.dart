import 'package:flutter/material.dart';

class CropRecommendationScreen extends StatefulWidget {
  const CropRecommendationScreen({super.key});

  @override
  State<CropRecommendationScreen> createState() =>
      _CropRecommendationScreenState();
}

class _CropRecommendationScreenState extends State<CropRecommendationScreen> {
  String? _selectedRegion;

  final Map<String, List<Map<String, dynamic>>> regionData = {
    'तराई': [
      {
        'name': 'काउली',
        'price': 'Rs. 45/kg',
        'image':
            'https://t4.ftcdn.net/jpg/00/55/94/57/360_F_55945753_8WOxMob7kAsVeXUMfSVauDzE4DIjbLxZ.jpg',
        'farmer': 'Ram Yadav'
      },
      {
        'name': 'आलु',
        'price': 'Rs. 30/kg',
        'image':
            'https://www.kew.org/sites/default/files/styles/original/public/2025-01/many-potatoes-solanum-tuberosum.jpg.webp?itok=RhcGjOE3',
        'farmer': 'Sita Chaudhary'
      },
      {
        'name': 'भिण्डी',
        'price': 'Rs. 35/kg',
        'image':
            'https://mediaproxy.salon.com/width/1200/https://media2.salon.com/2020/06/okra-0626201.jpg',
        'farmer': 'Hari Tharu'
      },
      {
        'name': 'धनियाँ',
        'price': 'Rs. 20/bunch',
        'image':
            'https://5.imimg.com/data5/JQ/KL/MY-16279308/dhaniya-seed-500x500.jpg',
        'farmer': 'Meena Sah'
      },
      {
        'name': 'केरा',
        'price': 'Rs. 50/dozen',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/8/8a/Banana-Single.jpg',
        'farmer': 'Lalita Mandal'
      },
      {
        'name': 'तरबुजा',
        'price': 'Rs. 25/kg',
        'image':
            'https://d2n7tchuu1wmsv.cloudfront.net/uploads/7312/products/1588219915_serenade.jpg',
        'farmer': 'Ganesh Chaudhary'
      },
      {
        'name': 'खरबुजा',
        'price': 'Rs. 40/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/e/e1/Melon_March_2010-1.jpg',
        'farmer': 'Manoj Yadav'
      },
      {
        'name': 'भिन्डी',
        'price': 'Rs. 32/kg',
        'image':
            'https://mediaproxy.salon.com/width/1200/https://media2.salon.com/2020/06/okra-0626201.jpg',
        'farmer': 'Rita Sah'
      },
      {
        'name': 'गोलभेंडा',
        'price': 'Rs. 38/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg',
        'farmer': 'Kamal Jha'
      },
      {
        'name': 'धनिया पात',
        'price': 'Rs. 18/bunch',
        'image':
            'https://khetifood.com/image/cache/catalog/kheti_criander-500x500.jpg',
        'farmer': 'Nisha Kumari'
      },
      {
        'name': 'लसुन',
        'price': 'Rs. 160/kg',
        'image':
            'https://republicaimg.nagariknewscdn.com/shared/web/uploads/media/GarlicCloves_20200317180251.jpg',
        'farmer': 'Suraj Tharu'
      },
      {
        'name': 'प्याज',
        'price': 'Rs. 55/kg',
        'image':
            'https://orchardfruit.com/cdn/shop/files/Red-Onion-1-lb.-The-Orchard-Fruit-72141081.jpg?crop=center&height=1200&v=1722937869&width=1200',
        'farmer': 'Shanti Devi'
      },
      {
        'name': 'कटहर',
        'price': 'Rs. 70/kg',
        'image':
            'https://images.everydayhealth.com/images/diet-nutrition/jackfruit-101-1440x810.jpg?sfvrsn=8803e5c1_5',
        'farmer': 'Dipendra Yadav'
      },
      {
        'name': 'नीबु',
        'price': 'Rs. 20/piece',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/e/e4/Lemon.jpg',
        'farmer': 'Preeti Sah'
      },
      {
        'name': 'भिन्डी',
        'price': 'Rs. 34/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/f/f4/Okra_2005.jpg',
        'farmer': 'Radha Tharu'
      },
      {
        'name': 'गाजर',
        'price': 'Rs. 45/kg',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvRhVZ8jFjfXuQciWCZbBcmVWcvZQK49M75w&s',
        'farmer': 'Ramesh Mandal'
      },
      {
        'name': 'चिचिण्डो',
        'price': 'Rs. 22/kg',
        'image':
            'https://sewapoint.com/image-1653898992941-bottle-gourd-500x500-1.jpg',
        'farmer': 'Geeta Kumari'
      },
      {
        'name': 'बाँसको टुप्पो',
        'price': 'Rs. 60/kg',
        'image':
            'https://www.ohmyfoodrecipes.com/wp-content/uploads/2020/07/boiled-bamboo-shoots-on-plate.jpg',
        'farmer': 'Binod Yadav'
      },
      {
        'name': 'अदुवा',
        'price': 'Rs. 90/kg',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuq0vCeab4OFGS9PKndgk0YkcASePzkKA9jQ&s',
        'farmer': 'Sunita Devi'
      },
      {
        'name': 'भुइँकटार',
        'price': 'Rs. 35/kg',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3EZenExcPl5a_leFkFbwu5jGw2Dv3dmI2fw&s',
        'farmer': 'Bijaya Sah'
      },
    ],
    'पहाड': [
      {
        'name': 'टमाटर',
        'price': 'Rs. 50/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg',
        'farmer': 'Kiran Rai'
      },
      {
        'name': 'साग',
        'price': 'Rs. 25/kg',
        'image':
            'https://www.greendna.in/cdn/shop/products/English_Spinach__67562.jpg?v=1607938113',
        'farmer': 'Bimala Gurung'
      },
      {
        'name': 'गाजर',
        'price': 'Rs. 40/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/3/3e/Carrots.jpg',
        'farmer': 'Deepak BK'
      },
      {
        'name': 'फर्सी',
        'price': 'Rs. 28/kg',
        'image':
            'https://cdn.pixabay.com/photo/2014/10/26/17/25/pumpkin-504064_1280.jpg',
        'farmer': 'Rita Magar'
      },
      {
        'name': 'लसुन',
        'price': 'Rs. 160/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/4/49/GarlicBasket.jpg',
        'farmer': 'Anita Ghale'
      },
      {
        'name': 'काँक्रो',
        'price': 'Rs. 30/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/4/43/Cucumis_sativus_-_cucumber_-_FMNH.jpg',
        'farmer': 'Shyam KC'
      },
      {
        'name': 'गोलभेंडा',
        'price': 'Rs. 38/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/6/64/Tomatoes.jpg',
        'farmer': 'Mina Lama'
      },
      {
        'name': 'सिमी',
        'price': 'Rs. 50/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/b/b5/Phaseolus_vulgaris_-_Beans.jpg',
        'farmer': 'Raju Thapa'
      },
      {
        'name': 'भेन्टा',
        'price': 'Rs. 35/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/6/64/Eggplants.jpg',
        'farmer': 'Pushpa Rana'
      },
      {
        'name': 'किवी',
        'price': 'Rs. 120/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/d/d3/Kiwi_aka.jpg',
        'farmer': 'Roshan Gurung'
      },
      {
        'name': 'आरु',
        'price': 'Rs. 90/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/2/22/Peach_and_cross_section.jpg',
        'farmer': 'Sunil Pun'
      },
      {
        'name': 'आरुबखडा',
        'price': 'Rs. 85/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/f/f6/Prunus_domestica.jpg',
        'farmer': 'Puskar Lama'
      },
      {
        'name': 'कागती',
        'price': 'Rs. 18/piece',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/6/6c/Limes.jpg',
        'farmer': 'Sarita Bhujel'
      },
      {
        'name': 'भुइँकटार',
        'price': 'Rs. 35/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/2/25/Taro_root.jpg',
        'farmer': 'Sagar KC'
      },
      {
        'name': 'बन्दकपी',
        'price': 'Rs. 30/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/f/f7/Cabbage_and_cross_section_on_white.jpg',
        'farmer': 'Ramesh Pariyar'
      },
      {
        'name': 'काउली',
        'price': 'Rs. 45/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/1/1c/Cauliflower.jpg',
        'farmer': 'Tara Rana'
      },
      {
        'name': 'करेला',
        'price': 'Rs. 40/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/b/b2/Bitter_melon.jpg',
        'farmer': 'Sunita BK'
      },
      {
        'name': 'धनियाँ',
        'price': 'Rs. 20/bunch',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/e/eb/Coriander_leaves.jpg',
        'farmer': 'Juna Magar'
      },
      {
        'name': 'अदुवा',
        'price': 'Rs. 95/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/5/5e/Ginger_2.jpg',
        'farmer': 'Manju Gurung'
      },
      {
        'name': 'सुन्तला',
        'price': 'Rs. 60/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/0/0c/Mandarin_Oranges.jpg',
        'farmer': 'Bijaya Pun'
      },
    ],
    'हिमाल': [
      {
        'name': 'स्याउ',
        'price': 'Rs. 100/kg',
        'image':
            'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?w=400',
        'farmer': 'Tashi Lama'
      },
      {
        'name': 'किवी',
        'price': 'Rs. 120/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/d/d3/Kiwi_aka.jpg',
        'farmer': 'Sonam Sherpa'
      },
      {
        'name': 'मुगा',
        'price': 'Rs. 90/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/7/7c/Radish_on_white.jpg',
        'farmer': 'Lakpa Tamang'
      },
      {
        'name': 'पालुंगो',
        'price': 'Rs. 35/kg',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSFTOcDZzD9-n8vu63sj8VQ1wUNNT8EXrbyA&usqp=CAU',
        'farmer': 'Nima Sherpa'
      },
      {
        'name': 'आरु',
        'price': 'Rs. 95/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/2/22/Peach_and_cross_section.jpg',
        'farmer': 'Karma Bhote'
      },
      {
        'name': 'कागती',
        'price': 'Rs. 20/piece',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/6/6c/Limes.jpg',
        'farmer': 'Dolma Sherpa'
      },
      {
        'name': 'बन्दकपी',
        'price': 'Rs. 40/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/f/f7/Cabbage_and_cross_section_on_white.jpg',
        'farmer': 'Lhakpa Lama'
      },
      {
        'name': 'काउली',
        'price': 'Rs. 50/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/1/1c/Cauliflower.jpg',
        'farmer': 'Tenzing Sherpa'
      },
      {
        'name': 'भेन्डी',
        'price': 'Rs. 45/kg',
        'image':
            'https://cdn.britannica.com/93/138493-050-0C5E9D53/Okra-pod.jpg',
        'farmer': 'Sita Lama'
      },
      {
        'name': 'गाजर',
        'price': 'Rs. 55/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/3/3e/Carrots.jpg',
        'farmer': 'Norbu Sherpa'
      },
      {
        'name': 'टमाटर',
        'price': 'Rs. 60/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg',
        'farmer': 'Dawa Tamang'
      },
      {
        'name': 'भुइँकटार',
        'price': 'Rs. 45/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/2/25/Taro_root.jpg',
        'farmer': 'Pasang Bhote'
      },
      {
        'name': 'चिचिण्डो',
        'price': 'Rs. 30/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/d/df/Lauki.jpg',
        'farmer': 'Tsewang Lama'
      },
      {
        'name': 'सुन्तला',
        'price': 'Rs. 65/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/0/0c/Mandarin_Oranges.jpg',
        'farmer': 'Lhamu Gurung'
      },
      {
        'name': 'मुला',
        'price': 'Rs. 35/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/f/f8/Daikon.jpg',
        'farmer': 'Pema Lama'
      },
      {
        'name': 'भेंटा',
        'price': 'Rs. 50/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/6/64/Eggplants.jpg',
        'farmer': 'Nawang Sherpa'
      },
      {
        'name': 'करेला',
        'price': 'Rs. 42/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/b/b2/Bitter_melon.jpg',
        'farmer': 'Dolkar Bhote'
      },
      {
        'name': 'सिमी',
        'price': 'Rs. 55/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/b/b5/Phaseolus_vulgaris_-_Beans.jpg',
        'farmer': 'Jangbu Sherpa'
      },
      {
        'name': 'कागती',
        'price': 'Rs. 25/piece',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/f/fd/Lemon.jpg',
        'farmer': 'Sonam Tamang'
      },
      {
        'name': 'अदुवा',
        'price': 'Rs. 100/kg',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/5/5e/Ginger_2.jpg',
        'farmer': 'Nima Bhote'
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final crops = _selectedRegion != null ? regionData[_selectedRegion!]! : [];

    return Scaffold(
      appBar: AppBar(title: const Text("बाली सिफारिसहरू")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'क्षेत्र छान्नुहोस्',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['तराई', 'पहाड', 'हिमाल'].map((region) {
                final isSelected = _selectedRegion == region;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRegion = region;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green : Colors.grey[200],
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              )
                            ]
                          : [],
                    ),
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                      child: Text(region),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: crops.isEmpty
                  ? const Text('देखाउन कुनै बाली छैन। क्षेत्र छान्नुहोस्।')
                  : ListView.builder(
                      itemCount: crops.length,
                      itemBuilder: (context, index) {
                        final crop = crops[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                crop['image'],
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image),
                              ),
                            ),
                            title: Text(crop['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Price: ${crop['price']}'),
                                Text('Farmer: ${crop['farmer']}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
