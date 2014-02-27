luke = User.create(
  username: 'NYLuke164',
  email: 'luke@gschool.com',
  bio: 'Ummm...',
  password: 'luke',
  password_confirmation: 'luke',
  locale: 'es',
  last_drink: Time.now
)

billy = User.create(
  username: 'billygriffin22',
  email: 'billy@gschool.com',
  bio: 'I\'m your Local Smokehouse specializing in Home-Cooked Southern Style BBQ & Cajun Dishes, All Natural Burgers, and the Finest Selection of Micro-Brews. ',
  password: 'billy',
  password_confirmation: 'billy',
  locale: 'en',
  last_drink: Time.now - 2.days
)

ben_l = User.create(
  username: 'fluxusfrequency',
  email: 'ben_l@gschool.com',
  bio: 'Web Developer & Bluegrass Fiddle Player',
  password: 'ben_l',
  password_confirmation: 'ben_l',
  locale: 'en',
  last_drink: Time.now - 1.week
)

ben_h = User.create(
  username: 'benhorne44',
  email: 'ben_h@gschool.com',
  bio: 'Student at @gSchool',
  password: 'ben_h',
  password_confirmation: 'ben_h',
  locale: 'fr',
  last_drink: Time.now - 1.month
)

tyler = User.create(
  username: 'TeaPane',
  email: 'tyler@gschool.com',
  bio: 'Voulez vouz coucher avec moi',
  password: 'tyler',
  password_confirmation: 'tyler',
  locale: 'fr',
  last_drink: Time.now - 1.minute
)

jorge = User.create(
  username: 'novohispano',
  email: 'jorge@gschool.com',
  bio: 'Soñador profesional. Rubí / Ruby on Rails Developer. Desarrollo de Negocio en JumpstartLab.',
  password: 'jorge',
  password_confirmation: 'jorge',
  locale: 'es',
  last_drink: Time.now - 1.year
)

jeff = User.create(
  username: 'j3',
  email: 'jeff@gschool.com',
  bio: 'Don\'t talk about it, be about it. Principal at Jumpstart Lab, co-creator of Hungry Academy, gSchool, and member of CodeNow and Teach For America STEM boards.',
  password: 'jeff',
  password_confirmation: 'jeff',
  locale: 'en',
  last_drink: Time.now - 5.years
)

nathaniel = User.create(
  username: 'thewatts',
  email: 'nathaniel@gschool.com',
  bio: 'Saved by grace, Husband to @thekatiewatts, Blessed beyond comprehension.',
  password: 'nathaniel',
  password_confirmation: 'nathaniel',
  locale: 'en',
  last_drink: Time.now - 28.years
)

kevin = User.create(
  username: 'Code_Union',
  email: 'kevin@gschool.com',
  bio: 'Coder and entrepreneur, lover of Linus.',
  password: 'kevin',
  password_confirmation: 'kevin',
  locale: 'en',
  last_drink: Time.now
)

adam = User.create(
  username: 'adam_magan',
  email: 'adam@gschool.com',
  bio: 'Umm... I made you a pizza?',
  password: 'adam',
  password_confirmation: 'adam',
  locale: 'en',
  last_drink: Time.now - 8.years
)

puts "seeded the users!"

users = [ luke, billy, ben_l, ben_h, tyler, jorge, jeff, nathaniel, kevin, adam ]





### FRIENDSHIPS

begin
  users.each do |user|
    4.times { |i| user.friendships.create(friend_id: rand(9) + 1, status: 'accepted') }

    begin
      3.times { user.friendships.create(friend_id: rand(9) + 1, status: 'pending') }
    rescue
      puts "already friends!"
      retry
    end
  end
rescue
  puts "problem with the friendships! :( :( :("
  User.destroy_all
end
puts "created the friendships"



### ENTRIES

FRENCH_ENTRY_1 = "En Août 1979, j'ai pris mon dernier verre . Il était environ quatre heures un samedi après-midi , la chaleur du soleil en continu à travers les fenêtres de ma petite maison de transport sur ​​Dickens . Je mets un verre de scotch et de la soude sur la table du salon , je suis allé au lit , et tiré les couvertures sur ma tête . Je ne pouvais pas prendre plus . Le lundi, je suis allé visiter vieux sage Dr Jakob Schlichter . J'avais été le voyais pendant un an , en lui disant que je pensais que je pourrais boire trop . Il a accepté , et m'a conseillé d'aller à \" AAA \", qui est ce qu'il a appelé. Pressenti comme un lieu où l'on vous apprend à boire et conduire . J'ai dit que je n'avais pas besoin d' aller à toutes les réunions . Je voudrais arrêter de boire tout seul. Il m'a dit d'aller de l'avant et essayer , et vérifier avec lui tous les mois . Le problème avec l'aide de la volonté de puissance , pour moi , c'est que ça a duré seulement jusqu'à ce que ma volonté m'a convaincu que je pouvais prendre un autre verre . À cette époque , je lisais L'art de manger , par MFK Fisher , qui a écrit : \" . . Un martini est juste deux martinis sont trop Trois martinis sont jamais assez . \" Le problème de faire des résolutions , c'est que vous êtes sobre lorsque vous faire le premier , ont bu un verre quand vous faites le second , et ainsi de suite . J'ai aussi entendu dire , vous prenez la première boisson . La deuxième boisson elle-même prend . C'était mon problème . Je trouve qu'il est difficile , une fois que j'ai commencé , à arrêter après un ou deux. Si je pouvais, je continuerais jusqu'à que j'ai décidé de finir , qui était habituellement quelques heures plus tard . Le lendemain, j'ai payé le prix à la gueule de bois ."
FRENCH_ENTRY_TITLE_1 = "Mer de l'humanité"
FRENCH_ENTRY_2 = "Supposons que nous sommes tous liés par la conscience. Il ya suffisamment de philosophies et théories scientifiques des temps modernes là-bas qui suggèrent que nous sommes. En supposant que ce sont ou du moins peut-être, oui, à une manière très réelle, les gens autour de nous sont des aspects de nous-mêmes. Si nous sommes tous «un seul esprit», il s'ensuit que tout le monde est, par essence, nous-mêmes. Comment nous traitons les autres devient alors le reflet de la façon dont nous nous traitons. Et la façon dont nous nous traitons est à son tour la façon dont nous traitons les autres. Par exemple, presque tout le monde a peur de la mort, de mourir. Une des façons dont nous pouvons nous apaiser, altruiste, c'est-à apaiser les autres, d'être un bon ami, d'être un visage heureux, d'être un bon auditeur. Nous sommes tous dans le même. Compassion est de savoir ce et d'atteindre. Ce faisant, nous nous aidons ainsi - aider nous-mêmes, l'ensemble de la mer de l'humanité."
FRENCH_ENTRY_TITLE_2 = "Mise à jour sur un samedi soir!"
FRENCH_ENTRY_3 = "Eh bien , il est presque dimanche, mais qui est encore plus triste vraiment ... cette habitude d'être la fête la clé! Je n'ai pas mis à jour pour un couple de jours purement parce que je n'ai pas eu beaucoup à dire. Je n'ai pas réussi la réunion de jeudi alors que je tentais de mettre un formulaire de demande d'emploi ainsi que devait être dans la mi-journée vendredi. La vérité est que je veux - et sera - à une autre réunion bientôt ( probablement lundi) mais c'est parce que je veux aller et d'être dans une chambre avec les autres membres. En termes de devoir , je ne me sens pas comme ça , et c'est en grande partie parce que je suis à la maison . Je m'efforce de trouver un nouvel emploi et je serai heureux quand je reçois un, mais je vais véritablement verrai que le véritable test de la façon dont la sobriété est dans ma vie , une fois que cela arrive . Comme je l'ai dit avant , je trouve le « samedi tea-time ' dur car il a toujours été ma partie préférée de la soirée ... d'obtenir les premiers verres bas nous , la gouaille avec les gars , anticipant la nuit de plaisir à venir. Mais ce soir, j'ai même réussi à brise à travers parce que j'ai eu un curry :-) Ne vous que si tordu , je ne reçois pas de complaisance sur ma sobriété . Voici un exemple - samedi soir prochain nous avons une nuit . Je peux à peine le permettre , mais ce sera bien parce que je bois chaleureux . Cependant , si je sens que je ne peux pas le faire , alors je vais soit pas sortir ou si je me sens comme ça quand je suis , je vais rentrer à la maison plus tôt. L'essentiel est que je pense que je vais être correct, mais , alors que je suis heureux que la réflexion sur verre est définitivement s'atténue , je suis prêt à jouer très sûr en cas de besoin . Il sera probablement agacer certaines personnes, cependant mes vrais potes vont comprendre , et l'enfer pour toute personne qui a un problème avec elle . Donc, c'est tout. A mi-chemin à travers le week-end , et se sentir heureux . Pas trop mal pour KIMBO !"
FRENCH_ENTRY_TITLE_3 = "Mon nom est Roger, et je suis un alcoolique"

SPANISH_ENTRY_1 = "Ese es el tiempo que he estado sobrio . Ha sido bueno . Yo no he estado en una reunión de AA en un tiempo , así que tengo pensado ir mañana . Yo iba a ir el lunes, pero solicité dos trabajos que habían fechas de cierre de ayer y de hoy, así que opté por retrasar mi asistencia a la reunión de tres días. Estoy muy ansioso por ella. Pero estoy contento con dos meses. Por supuesto. He estado pensando en los últimos días acerca de la forma en que es una lástima que nunca tuve una sesión de despedida. No es que tengo la intención de tener un gran final ni nada, sólo de pensar que es una lástima que la última vez que tuve una bebida era por mi cuenta y no entre amigos. Pero la mayor parte de mi forma de beber en los últimos meses fue por mi cuenta con los auriculares voladura música en mis oídos ; escapismo simplemente absoluta. Otro aniversario es hoy y que es mi papá no ha tenido un cigarrillo en 14 meses. Lo que significa que el último día de su primer año de no fumadores era mi primer día de sobriedad ... ¡qué extraña coincidencia que era! Estoy muy orgulloso de él. Estoy seguro de que en muchos sentidos es muy similar , lo que está pasando. Hay diferencias obvias , pero estoy seguro de que hay algunas similitudes también. No he tenido el deseo de beber desde el viernes, lo cual es bueno . Fui al pub para el almuerzo ayer y no tenía ningún deseo en absoluto para tomar una copa . La persona que conocí para el almuerzo tenía una pinta y no a mí, no molesta en absoluto , de hecho , si sospecho que alguien no está bebiendo en mi nombre que me hace sentir más incómodo. Admito que no quiero estar rodeado de gente borracha y puedo controlar esas circunstancias. Sin embargo , realmente no tengo ningún problema con la gente que bebe en mi compañía , y espero que nunca nadie se siente como que no deben beber a mi alrededor. Así , poco más de la mitad del camino a través de la semana y que ha sido una buena semana hasta ahora. Sería bueno terminar con una 66m EUR Euromillones ganar el viernes!"
SPANISH_ENTRY_TITLE_1 = "Dos Meses Ayer"
SPANISH_ENTRY_2 = "Siempre me pareció extraño que había que bajar a un sótano de la iglesia para lograr la sobriedad , especialmente si usted es propenso a la depresión, creía en la religión , y / o sensibilidad a su entorno. Pero cuando era más joven , pensé que Alcohólicos Anónimos ( AA) fue la única manera de que los alcohólicos a lograr la sobriedad . Mi mamá se fue , que trabajó para ella, y nunca he oído hablar de cualquier otra opción . La gente que conocía que abandonaron generalmente recayeron , o al menos eso parecía . Últimamente , AA ha sido objeto de críticas . Lo más notable de Gabrielle Glaser, autor de un nuevo libro popular acerca de las mujeres y la bebida, \"Her Best- Kept Secret \". Afirma que AA puede ser un lugar peligroso para las mujeres, las personas con múltiples problemas de asistir a las reuniones libremente ( los delincuentes sexuales con problemas de alcohol , por ejemplo) . Ahora, un nuevo estudio sugiere que el modelo actual de AA puede ser más eficaz para los hombres que en las mujeres . Investigadores del Hospital General de Massachusetts encontraron que los hombres tienden a recaer cuando se encuentran en situaciones sociales con otros bebedores. AA ayuda a los alcohólicos a mantenerse sobrios hombres ofreciendo camaradería con otros abstemios , y dándoles los mecanismos de supervivencia para cuando están con amigos que beben ."
SPANISH_ENTRY_TITLE_2 = "Mar de la Humanidad"
SPANISH_ENTRY_3 = "¿Cómo asegurarse de que sus niños estén seguros cuando se quedan solos con un alcohólico o ? ¿Cómo se puede confiar en cualquier cosa que su adicto o alcohólico co - padre dice ? ¿Qué recursos existen para ayudar a una mamá o papá cuando compartir a sus hijos con un alcohólico o ? ¿Qué es lo que hay que ver si comparten los niños con un mentiroso y usuario conocido ? ¿Cómo se hace lo que es mejor para los niños ( tiempo máximo con cada padre , lucha observada mínimo ), mientras que se mantiene la seguridad de los niños pequeños ? Estas son las preguntas que he lidiado por casi un año . Y déjenme decirles , no hay respuestas claras y no hay camino marcado . Esto se siente como un territorio desconocido , con un lunático como mi copiloto. Cuando Construí un documento de separación legal, con la ayuda de mi abogado , yo no sabía qué diablos estaba haciendo . No estaba muy seguro , ya sea , ella es un buen abogado, pero no es un experto en materia de adicción. Como lo que he encontrado , muy pocos lo son. Le pregunté a varios consejeros en nuestras instalaciones de rehabilitación favorito ( pronto - a-ser - ex es un asistente en dos tiempos , graduado tiempo 0) , pero no me gusta involucrarse en asuntos de custodia . Off the record un consejero me dijo que era aconsejable ser estricto y que en base a la poca recuperación que había visto y lo que sabe de las drogas peligrosas Zach estaba usando , no confiaría en él a solas , tampoco. Le pregunté a un experto en la crianza de oficio, que no estaba segura tampoco, pero seguro que el tribunal había asignado a alguien? No, le respondí , que firmó un acuerdo de separación sin conseguir un abogado , evitamos los tribunales. Ella tenía ningún consejo que dar. Así que estoy solo en esto , por lo que es como me voy, con sólo mi Poder Superior , mi intuición y mi limitado conocimiento de la adicción / alcoholismo para que me de ."
SPANISH_ENTRY_TITLE_3 = "¿Es AA la única opción? Ya no más."


begin
  users.each_with_index do |user, i|
    if user.locale == 'en'
      3.times do |i|
        entry = Entry.all[rand(11)].dup
        entry.update_attributes(section: "Section 1", user_id: user.id)
        entry.save
      end
    elsif user.locale == 'fr'
      3.times do |i|
        user.entries.create(step: i + 1, body: eval("FRENCH_ENTRY_#{i+1}"), title: eval("FRENCH_ENTRY_TITLE_#{i+1}"), section: "1") 
      end
    elsif user.locale == 'es'
      3.times do |i|
        user.entries.create(step: i + 1, body: eval("SPANISH_ENTRY_#{i+1}"), title: eval("SPANISH_ENTRY_TITLE_#{i+1}"), section: "1") 
      end
    end
  end
  puts "seeded the entries!"
rescue
  puts "it broke on entries :< :< :<"
  User.destroy_all
end








### STATUSES


ENGLISH_STATUSES = [ 
  "Hanging in there!",
  "I'm looking for a sponsor. Does anyone know of someone who could help me in the Denver area?",
  "Wow, I just signed up for 12Stepper. After taking a look around, I really like it! It's awesome!",
  "I'm having a difficult day today. Please send your prayers and encouragement",
  "We're starting a new meeting in Madison, WI. It's at St. James Church in the basement, MWF at 8:00PM. Hope you can join us!",
  "I just finished working my fourth step in my journal in here. Looking forward to making amends and moving forward.",
  "Two years down. Getting easier every day!"]

FRENCH_STATUSES = [
  "Hanging là!", 
  "Je suis à la recherche d'un sponsor. Est-ce que quelqu'un sait de quelqu'un qui pourrait m'aider dans la région de Denver?", 
  "Wow, je viens de m'inscrire pour 12Stepper. Après avoir pris un coup d'oeil autour, je l'aime vraiment! C'est génial!", 
  "Je vais avoir une journée difficile aujourd'hui. S'il vous plaît envoyez vos prières et votre encouragement", 
  "Nous commençons une nouvelle réunion à Madison, WI. C'est à l'église St. James dans le sous-sol, MWF à 20h00. J'espère que vous pourrez vous joindre à nous!", 
  "Je viens de terminer mon travail quatrième étape dans mon journal ici. Plaisir de faire amende honorable et aller de l'avant.", 
  "Deux ans plus tard. Obtenir plus facile tous les jours!" 
]

SPANISH_STATUSES = [
  "Colgando ahí!",
  "Estoy buscando un patrocinador. ¿Alguien sabe de alguien que me pueda ayudar en el área de Denver?", 
  "Wow, me inscribí en 12Stepper. Después de echar un vistazo alrededor, me gusta mucho! ¡Es increíble!",
  "Estoy teniendo un día difícil hoy en día. Favor de enviar sus oraciones y aliento", 
  "Estamos comenzando una nueva reunión en Madison, WI. Es en la Iglesia de Santiago en el sótano, MWF a las 8:00 PM. Espero que puedan unirse a nosotros!", 
  "Acabo de terminar de trabajar mi cuarto paso en mi diario aquí. Esperamos poder hacer las paces y seguir adelante.",
  "Dos años más tarde. Conseguir más fácil todos los días!" 
]

begin
  users.each do |user|
    user.statuses.create(content: user.entries.first.to_status)
    if user.locale == 'en'
      2.times { user.statuses.create(content: ENGLISH_STATUSES[rand(7)]) }
    elsif user.locale == 'fr'
      2.times { user.statuses.create(content: FRENCH_STATUSES[rand(7)]) }
    elsif user.locale == 'es'
      2.times { user.statuses.create(content: SPANISH_STATUSES[rand(7)]) }
    end
  end
  puts "seeded the statuses!"
rescue
  require 'pry'; binding.pry
  puts "problem with the statuses :("
  User.destroy_all
end

