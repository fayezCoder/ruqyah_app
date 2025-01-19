import '../models/dhikr.dart';

class DhikrService {
  static List<DhikrCategory> getAllDhikrCategories() {
    return [
      DhikrCategory(
        name: 'أذكار الصباح',
        icon: '🌅',
        dhikrs: [
          Dhikr(
            text: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَٰهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
            translation: 'We have reached the morning and at this very time unto Allah belongs all sovereignty, and all praise is for Allah. None has the right to be worshipped except Allah, alone, without any partner, to Him belongs all sovereignty and praise and He is over all things omnipotent.',
            reference: 'رواه أبو داود',
            repeat: 1,
          ),
          Dhikr(
            text: 'اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ النُّشُورُ',
            translation: 'O Allah, by You we enter the morning and by You we enter the evening, by You we live and by You we die, and to You is the resurrection.',
            reference: 'رواه الترمذي',
            repeat: 1,
          ),
        ],
      ),
      DhikrCategory(
        name: 'أذكار المساء',
        icon: '🌙',
        dhikrs: [
          Dhikr(
            text: 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَٰهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
            translation: 'We have reached the evening and at this very time unto Allah belongs all sovereignty, and all praise is for Allah. None has the right to be worshipped except Allah, alone, without any partner, to Him belongs all sovereignty and praise and He is over all things omnipotent.',
            reference: 'رواه أبو داود',
            repeat: 1,
          ),
        ],
      ),
      DhikrCategory(
        name: 'أذكار النوم',
        icon: '😴',
        dhikrs: [
          Dhikr(
            text: 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا',
            translation: 'In Your name O Allah, I live and die.',
            reference: 'رواه البخاري',
            repeat: 1,
          ),
          Dhikr(
            text: 'اللَّهُمَّ قِنِي عَذَابَكَ يَوْمَ تَبْعَثُ عِبَادَكَ',
            translation: 'O Allah, protect me from Your punishment on the day Your servants are resurrected.',
            reference: 'رواه أبو داود',
            repeat: 3,
          ),
        ],
      ),
      DhikrCategory(
        name: 'أذكار بعد الصلاة',
        icon: '🤲',
        dhikrs: [
          Dhikr(
            text: 'أَسْتَغْفِرُ اللَّهَ',
            translation: 'I seek forgiveness from Allah',
            reference: 'رواه مسلم',
            repeat: 3,
          ),
          Dhikr(
            text: 'اللَّهُمَّ أَنْتَ السَّلامُ، وَمِنْكَ السَّلامُ، تَبَارَكْتَ يَا ذَا الْجَلالِ وَالإِكْرَامِ',
            translation: 'O Allah, You are Peace and from You comes peace. Blessed are You, O Owner of majesty and honor.',
            reference: 'رواه مسلم',
            repeat: 1,
          ),
          Dhikr(
            text: 'لا إِلَهَ إِلا اللَّهُ وَحْدَهُ لا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، اللَّهُمَّ لا مَانِعَ لِمَا أَعْطَيْتَ، وَلا مُعْطِيَ لِمَا مَنَعْتَ، وَلا يَنْفَعُ ذَا الْجَدِّ مِنْكَ الْجَدُّ',
            translation: 'None has the right to be worshipped but Allah alone, He has no partner, His is the dominion and His is the praise, and He is Able to do all things. O Allah, there is none who can withhold what You give, and none can give what You withhold, and the might of the mighty person cannot benefit him against You.',
            reference: 'متفق عليه',
            repeat: 1,
          ),
          Dhikr(
            text: 'لا إِلَهَ إِلا اللَّهُ وَحْدَهُ لا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، لا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ، لا إِلَهَ إِلا اللَّهُ، وَلا نَعْبُدُ إِلا إِيَّاهُ، لَهُ النِّعْمَةُ وَلَهُ الْفَضْلُ وَلَهُ الثَّنَاءُ الْحَسَنُ، لا إِلَهَ إِلا اللَّهُ مُخْلِصِينَ لَهُ الدِّينَ وَلَوْ كَرِهَ الْكَافِرُونَ',
            translation: 'None has the right to be worshipped but Allah alone, He has no partner, His is the dominion and His is the praise and He is Able to do all things. There is no might or power except with Allah. None has the right to be worshipped but Allah and we do not worship any other besides Him. His is grace, and His is bounty and to Him belongs the most excellent praise. None has the right to be worshipped but Allah. (We are) sincere in making our religious devotion to Him, even though the disbelievers may detest it.',
            reference: 'رواه مسلم',
            repeat: 1,
          ),
          Dhikr(
            text: 'سُبْحَانَ اللَّهِ',
            translation: 'Glory be to Allah',
            reference: 'متفق عليه',
            repeat: 33,
          ),
          Dhikr(
            text: 'الْحَمْدُ لِلَّهِ',
            translation: 'All praise is due to Allah',
            reference: 'متفق عليه',
            repeat: 33,
          ),
          Dhikr(
            text: 'اللَّهُ أَكْبَرُ',
            translation: 'Allah is the Greatest',
            reference: 'متفق عليه',
            repeat: 33,
          ),
          Dhikr(
            text: 'لا إِلَهَ إِلا اللَّهُ وَحْدَهُ لا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
            translation: 'None has the right to be worshipped but Allah alone, He has no partner, His is the dominion and His is the praise and He is Able to do all things.',
            reference: 'متفق عليه',
            repeat: 1,
          ),
          Dhikr(
            text: 'قُلْ هُوَ اللَّهُ أَحَدٌ...',
            translation: 'Say: He is Allah, [who is] One... (Surah Al-Ikhlas)',
            reference: 'رواه أبو داود والترمذي',
            repeat: 1,
          ),
          Dhikr(
            text: 'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ...',
            translation: 'Say: I seek refuge in the Lord of daybreak... (Surah Al-Falaq)',
            reference: 'رواه أبو داود والترمذي',
            repeat: 1,
          ),
          Dhikr(
            text: 'قُلْ أَعُوذُ بِرَبِّ النَّاسِ...',
            translation: 'Say: I seek refuge in the Lord of mankind... (Surah An-Nas)',
            reference: 'رواه أبو داود والترمذي',
            repeat: 1,
          ),
          Dhikr(
            text: 'آيَةُ الْكُرْسِيِّ: اللَّهُ لا إِلَهَ إِلا هُوَ الْحَيُّ الْقَيُّومُ...',
            translation: 'Allah - there is no deity except Him, the Ever-Living, the Sustainer of [all] existence... (Ayat Al-Kursi)',
            reference: 'رواه النسائي',
            repeat: 1,
          ),
        ],
      ),
      DhikrCategory(
        name: 'أدعية قرآنية',
        icon: '📖',
        dhikrs: [
          Dhikr(
            text: 'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
            translation: 'Our Lord, give us in this world [that which is] good and in the Hereafter [that which is] good and protect us from the punishment of the Fire.',
            reference: 'البقرة: 201',
            repeat: 1,
          ),
        ],
      ),
    ];
  }
}
