<template>
    <!-- Header -->

    <header
        class="bg-[#000A2B] w-full h-[85px] z-60 px-10 md:h-[100px] flex justify-between items-center  md:px-12 font-poppins fixed top-0 left-0 shadow-lg">

        <!-- Logo -->
        <section class="flex gap-2 w-3/5 md:w-2/5 justify-center text-[24px] md:text-[35px]">

            <img src="./../assets/image/dev.png" alt="mon logo" class="text-white w-3/5 h-auto">
        </section>

        <!-- Menu Desktop (caché sur mobile) -->
        <ul class="hidden md:flex text-white justify-around w-2/5 items-center text-[16px] gap-6 lg:gap-8">

            <a href="#accueil">
                <li class="hover:text-[#1c9892] duration-300 hover:scale-105 cursor-pointer">Accueil</li>
            </a>
            <a href="#Apropos">
                <li class="hover:text-[#0FDBD0] duration-300 hover:scale-105 cursor-pointer">A propos</li>
            </a>
            <li class="hover:text-[#0FDBD0] duration-300 hover:scale-105 cursor-pointer">Projets</li>
            <li class="hover:text-[#0FDBD0] duration-300 hover:scale-105 cursor-pointer">Compétences</li>
            <li class="hover:text-[#0FDBD0] duration-300 hover:scale-105 cursor-pointer">Contact</li>
        </ul>

        <!-- Bouton Hamburger (visible uniquement sur mobile) -->
        <button class="md:hidden text-white hover:text-[#0FDBD0]  z-50" @click="isMenuOpen = !isMenuOpen">
            <svg v-if="!isMenuOpen" class="w-7 h-7" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
            </svg>
            <svg v-else class="w-7 h-7" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
        </button>
    </header>

    <!-- Menu Mobile (visible uniquement quand isMenuOpen = true) -->
    <div v-if="isMenuOpen" class="absolute inset-0 bg-black/20 backdrop-blur-[1px]"></div>

    <!-- Overlay -->
    <!-- Menu Mobile -->
    <div v-if="isMenuOpen" class="md:hidden fixed inset-0 z-50 bg-black/20 backdrop-blur-[1px] " @click="closeMenu">
        <!-- Panel du menu -->
        <div class="fixed top-0 right-0 bottom-0 w-1/2 bg-[#000A2B] shadow-2xl " @click.stop>
            <!-- Header avec bouton de fermeture -->
            <div class="flex justify-between items-center p-6 border-b border-slate-700 ">

                <h2 class=" text-[40px] font-semibold cursor-pointer text-[#0FDBD0]">Menu</h2>
                <button @click="closeMenu"
                    class="text-gray-400 hover:text-white transition-colors p-2 rounded-lg hover:bg-white/10">
                    <svg class="w-6 h-6 cursor-pointer" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>

            <!-- Navigation -->
            <nav class="flex flex-col p-4 gap-4">

                <!-- Accueil -->
                <a href="#accueil" @click="closeMenu"
                    class="flex items-center gap-3 px-4 py-4 text-white hover:text-[#0FDBD0] hover:bg-white/5 rounded-lg transition-all duration-200 border-b border-slate-700/50">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                        stroke="currentColor" class="w-6 h-6">
                        <path stroke-linecap="round" stroke-linejoin="round"
                            d="m2.25 12 8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25" />
                    </svg>
                    <span class="text-[17px] font-medium">Accueil</span>
                </a>

                <!-- À propos -->
                <a href="#Apropos" @click="closeMenu"
                    class="flex items-center gap-3 px-4 py-4 text-white hover:text-[#0FDBD0] hover:bg-white/5 rounded-lg transition-all duration-200 border-b border-slate-700/50">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                        stroke="currentColor" class="w-6 h-6">
                        <path stroke-linecap="round" stroke-linejoin="round"
                            d="M17.982 18.725A7.488 7.488 0 0 0 12 15.75a7.488 7.488 0 0 0-5.982 2.975m11.963 0a9 9 0 1 0-11.963 0m11.963 0A8.966 8.966 0 0 1 12 21a8.966 8.966 0 0 1-5.982-2.275M15 9.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                    </svg>
                    <span class="text-[17px] font-medium">À propos</span>
                </a>

                <!-- Projets -->
                <a href="#projet" @click="closeMenu"
                    class="flex items-center gap-3 px-4 py-4 text-white hover:text-[#0FDBD0] hover:bg-white/5 rounded-lg transition-all duration-200 border-b border-slate-700/50">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                        stroke="currentColor" class="w-6 h-6">
                        <path stroke-linecap="round" stroke-linejoin="round"
                            d="M12 3v17.25m0 0c-1.472 0-2.882.265-4.185.75M12 20.25c1.472 0 2.882.265 4.185.75M18.75 4.97A48.416 48.416 0 0 0 12 4.5c-2.291 0-4.545.16-6.75.47m13.5 0c1.01.143 2.01.317 3 .52m-3-.52 2.62 10.726c.122.499-.106 1.028-.589 1.202a5.988 5.988 0 0 1-2.031.352 5.988 5.988 0 0 1-2.031-.352c-.483-.174-.711-.703-.59-1.202L18.75 4.971Zm-16.5.52c.99-.203 1.99-.377 3-.52m0 0 2.62 10.726c.122.499-.106 1.028-.589 1.202a5.989 5.989 0 0 1-2.031.352 5.989 5.989 0 0 1-2.031-.352c-.483-.174-.711-.703-.59-1.202L5.25 4.971Z" />
                    </svg>
                    <span class="text-[17px] font-medium">Projets</span>
                </a>

                <!-- Compétences -->
                <a href="#competences" @click="closeMenu"
                    class="flex items-center gap-3 px-4 py-4 text-white hover:text-[#0FDBD0] hover:bg-white/5 rounded-lg transition-all duration-200 border-b border-slate-700/50">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                        stroke="currentColor" class="w-6 h-6">
                        <path stroke-linecap="round" stroke-linejoin="round"
                            d="M4.26 10.147a60.438 60.438 0 0 0-.491 6.347A48.62 48.62 0 0 1 12 20.904a48.62 48.62 0 0 1 8.232-4.41 60.46 60.46 0 0 0-.491-6.347m-15.482 0a50.636 50.636 0 0 0-2.658-.813A59.906 59.906 0 0 1 12 3.493a59.903 59.903 0 0 1 10.399 5.84c-.896.248-1.783.52-2.658.814m-15.482 0A50.717 50.717 0 0 1 12 13.489a50.702 50.702 0 0 1 7.74-3.342M6.75 15a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Zm0 0v-3.675A55.378 55.378 0 0 1 12 8.443m-7.007 11.55A5.981 5.981 0 0 0 6.75 15.75v-1.5" />
                    </svg>
                    <span class="text-[17px] font-medium">Compétences</span>
                </a>

                <!-- Contact -->
                <a href="#contact" @click="closeMenu"
                    class="flex items-center gap-3 px-4 py-4 text-white hover:text-[#0FDBD0] hover:bg-white/5 rounded-lg transition-all duration-200">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                        stroke="currentColor" class="w-6 h-6">
                        <path stroke-linecap="round" stroke-linejoin="round"
                            d="M8.625 12a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm0 0H8.25m4.125 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm0 0H12m4.125 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm0 0h-.375M21 12c0 4.556-4.03 8.25-9 8.25a9.764 9.764 0 0 1-2.555-.337A5.972 5.972 0 0 1 5.41 20.97a5.969 5.969 0 0 1-.474-.065 4.48 4.48 0 0 0 .978-2.025c.09-.457-.133-.901-.467-1.226C3.93 16.178 3 14.189 3 12c0-4.556 4.03-8.25 9-8.25s9 3.694 9 8.25Z" />
                    </svg>
                    <span class="text-[17px] font-medium">Contact</span>
                </a>

            </nav>

            <!-- Footer du menu (optionnel) -->
            <div class="absolute bottom-0 left-0 right-0 p-6 border-t border-slate-700">
                <p class="text-gray-400 text-sm text-center">© 2024 Portfolio</p>
            </div>
        </div>
    </div>
    <!-- Section Hero (Contenu principal) -->
    <div ref="vantaRef" class="w-full h-screen z-40  overflow-hidden">
        <section id="accueil"
            class=" w-full z-50 text-white font-poppins px-4 md:px-8 lg:px-16 py-12 md:py-20 mt-[80px] md:mt-[100px]">

            <!-- Container principal -->
            <div
                class="max-w-7xl mx-auto flex flex-col-reverse md:flex-row items-center justify-center  md:gap-12">

                <!-- Partie Texte (Gauche sur desktop, en bas sur mobile) -->
                <div class="flex flex-col gap-6 md:gap-8 w-full md:w-3/5 lg:w-1/2">

                    <!-- Titres et description -->
                    <div class="flex flex-col gap-4 text-center md:text-left">

                        <!-- Titre principal -->
                        <h1 class="text-[24px] md:text-[32px] lg:text-[40px] xl:text-[48px] leading-tight font-bold">
                            Je suis Ralph  <span class="text-red-500"> Sengue</span>
                        </h1>

                        <!-- Sous-titre -->
                        <h2 class="text-[20px] md:text-[26px] lg:text-[32px] font-semibold text-white">
                            Développeur Fullstack, Designer Graphique & Community Manager
                        </h2>

                        <!-- Description -->
                        <p class="text-[16px] md:text-[18px] lg:text-[20px] text-white leading-relaxed">
                            passionné par la logique métier et la conception de fonctionnalités robustes. J’accompagne les projets de la phase d’idée à la mise en production, en transformant les besoins en solutions techniques efficaces. Je suis également designer graphique et community manager, ce qui me permet d’avoir une vision complète des produits numériques.
                        </p>
                    </div>

                    <!-- Boutons d'action -->
                    <div class="flex flex-col sm:flex-row gap-4 mt-4 justify-center md:justify-start">
                        <!-- Bouton principal -->
                        <a href="#projet">
                            <button
                                class="bg-[#0FDBD0] flex justify-between items-center gap-2 w-full md:w-[250px] h-fit text-white font-semibold text-[16px] md:text-[18px] py-3 px-8 rounded-lg hover:bg-[#063432] duration-300 shadow-lg hover:shadow-xl transform hover:scale-105  translate-y-1 transition-all">

                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                    stroke-width="1.5" stroke="currentColor" class="size-6">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M20.25 6.375c0 2.278-3.694 4.125-8.25 4.125S3.75 8.653 3.75 6.375m16.5 0c0-2.278-3.694-4.125-8.25-4.125S3.75 4.097 3.75 6.375m16.5 0v11.25c0 2.278-3.694 4.125-8.25 4.125s-8.25-1.847-8.25-4.125V6.375m16.5 0v3.75m-16.5-3.75v3.75m16.5 0v3.75C20.25 16.153 16.556 18 12 18s-8.25-1.847-8.25-4.125v-3.75m16.5 0c0 2.278-3.694 4.125-8.25 4.125s-8.25-1.847-8.25-4.125" />
                                </svg>

                                Voir mes projets


                            </button>
                        </a>

                        <!-- Bouton secondaire -->
                        <a href="/CV SENGUE KENGNE RALPH LANDRY.pdf" download="CV SENGUE KENGNE RALPH LANDRY.pdf">
                            <button
                                class=" border-2 flex  justify-center items-center gap-4 md:w-[250px] h-fit border-[#0FDBD0] text-[#0FDBD0] font-semibold text-[16px] md:text-[18px] py-3 px-8 rounded-lg w-full  hover:bg-[#0FDBD0] hover:text-white duration-300 shadow-md hover:shadow-lg transform hover:scale-105 transition-all">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                    stroke-width="1.5" stroke="currentColor" class="size-6">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M3 16.5v2.25A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75V16.5M16.5 12 12 16.5m0 0L7.5 12m4.5 4.5V3">
                                    </path>
                                </svg>
                                <p>Mon CV</p>
                            </button>
                        </a>

                        <!-- Bouton PORTFOLIO -->
                        <a href="/portfolio SENGUE KENGNE RALPH LANDRY.pdf" download="portfolio SENGUE KENGNE RALPH LANDRY.pdf">
                            <button
                                class=" border-2 flex  justify-center items-center gap-4 md:w-[250px] h-fit border-[#0FDBD0] text-[#0FDBD0] font-semibold text-[16px] md:text-[18px] py-3 px-8 rounded-lg w-full  hover:bg-[#0FDBD0] hover:text-white duration-300 shadow-md hover:shadow-lg transform hover:scale-105 transition-all">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                    stroke-width="1.5" stroke="currentColor" class="size-6">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M3 16.5v2.25A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75V16.5M16.5 12 12 16.5m0 0L7.5 12m4.5 4.5V3">
                                    </path>
                                </svg>
                                <p>Mon portfolio</p>
                            </button>
                        </a>

                    </div>

                    <!-- Stats ou icônes sociales (optionnel) -->
                    <div class="flex gap-6 mt-6 justify-center md:justify-start text-gray-600">
                        <div class="flex items-center gap-2">
                            <svg class="w-5 h-5 text-[#0FDBD0]" fill="currentColor" viewBox="0 0 20 20">
                                <path
                                    d="M10 0C4.477 0 0 4.477 0 10c0 4.418 2.865 8.166 6.839 9.489.5.092.682-.217.682-.482 0-.237-.008-.866-.013-1.7-2.782.603-3.369-1.34-3.369-1.34-.454-1.156-1.11-1.463-1.11-1.463-.908-.62.069-.608.069-.608 1.003.07 1.531 1.03 1.531 1.03.892 1.529 2.341 1.087 2.91.831.092-.646.35-1.086.636-1.336-2.22-.253-4.555-1.11-4.555-4.943 0-1.091.39-1.984 1.029-2.683-.103-.253-.446-1.27.098-2.647 0 0 .84-.269 2.75 1.025A9.578 9.578 0 0110 4.836c.85.004 1.705.115 2.504.337 1.909-1.294 2.747-1.025 2.747-1.025.546 1.377.203 2.394.1 2.647.64.699 1.028 1.592 1.028 2.683 0 3.842-2.339 4.687-4.566 4.935.359.309.678.919.678 1.852 0 1.336-.012 2.415-.012 2.743 0 .267.18.578.688.48C17.138 18.163 20 14.418 20 10c0-5.523-4.477-10-10-10z" />
                            </svg>
                            <span class="text-sm">GitHub</span>
                        </div>
                        <div class="flex items-center gap-2">
                            <svg class="w-5 h-5 text-[#0FDBD0]" fill="currentColor" viewBox="0 0 20 20">
                                <path
                                    d="M16.338 16.338H13.67V12.16c0-.995-.017-2.277-1.387-2.277-1.39 0-1.601 1.086-1.601 2.207v4.248H8.014v-8.59h2.559v1.174h.037c.356-.675 1.227-1.387 2.526-1.387 2.703 0 3.203 1.778 3.203 4.092v4.711zM5.005 6.575a1.548 1.548 0 11-.003-3.096 1.548 1.548 0 01.003 3.096zm-1.337 9.763H6.34v-8.59H3.667v8.59zM17.668 1H2.328C1.595 1 1 1.581 1 2.298v15.403C1 18.418 1.595 19 2.328 19h15.34c.734 0 1.332-.582 1.332-1.299V2.298C19 1.581 18.402 1 17.668 1z" />
                            </svg>
                            <span class="text-sm">LinkedIn</span>
                        </div>
                    </div>
                </div>

             

            </div>
        </section>
    </div>
    <div ref="vantaRef1" class="w-full min-h-screen z-40">
        <!-- Section À Propos -->
        <section id="Apropos" class="py-20 pb-40 px-6 z-">
            <div class="max-w-7xl mx-auto">

                <!-- Titre de la section -->
                <div class="text-center mb-10">
                    <h2 class="text-5xl md:text-6xl font-bold text-white mb-4">
                        À Propos de <span class="text-red-500">Moi</span>
                    </h2>
                    <div class="w-24 h-1 bg-red-500 mx-auto rounded-full"></div>
                </div>

                <!-- Contenu principal -->
                <div class="grid md:grid-cols-2 md:gap-12 gap-8 ">

                    <!-- Partie Gauche - Texte -->
                    <div class="flex-1 flex-col ">

                        <!-- Introduction -->
                        <div
                            class="bg-white/5  rounded-2xl p-8 border border-white/10 hover:border-[#0FDBD0]/50 transition-all duration-300">
                            <h3 class="text-3xl font-bold text-white mb-4 flex items-center gap-3">
                                <span class="text-[#0FDBD0]">👋</span> Hello !
                            </h3>
                            <p class="text-gray-300 text-lg leading-relaxed">
                                Je suis Ralph <span class="text-red-500 font-semibold"> Sengue</span>, <strong class="text-white">développeur Backend</strong>
                                 passionnée par la logique cachée des différentes fonctionnalités des applications.
                                 Je suis également <strong class="text-white"> Designer Graphique</strong> et <strong class="text-white">Community Manager</strong>. Je transforme des besoins en modules fonctionnelles.
                            </p>
                        </div>
                        <div
                            class=" mt-3 bg-gradient-to-br from-[#0FDBD0]/10 to-transparent backdrop-blur-sm rounded-2xl p-8 border border-[#0FDBD0]/30  hover:border-[#0FDBD0]/60 transition-all duration-300">
                            <h3 class="text-2xl font-bold text-white mb-4 flex items-center gap-3">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                    stroke-width="1.5" stroke="currentColor" class="w-7 h-7 text-[#0FDBD0]">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M9.813 15.904 9 18.75l-.813-2.846a4.5 4.5 0 0 0-3.09-3.09L2.25 12l2.846-.813a4.5 4.5 0 0 0 3.09-3.09L9 5.25l.813 2.846a4.5 4.5 0 0 0 3.09 3.09L15.75 12l-2.846.813a4.5 4.5 0 0 0-3.09 3.09ZM18.259 8.715 18 9.75l-.259-1.035a3.375 3.375 0 0 0-2.455-2.456L14.25 6l1.036-.259a3.375 3.375 0 0 0 2.455-2.456L18 2.25l.259 1.035a3.375 3.375 0 0 0 2.456 2.456L21.75 6l-1.035.259a3.375 3.375 0 0 0-2.456 2.456ZM16.894 20.567 16.5 21.75l-.394-1.183a2.25 2.25 0 0 0-1.423-1.423L13.5 18.75l1.183-.394a2.25 2.25 0 0 0 1.423-1.423l.394-1.183.394 1.183a2.25 2.25 0 0 0 1.423 1.423l1.183.394-1.183.394a2.25 2.25 0 0 0-1.423 1.423Z" />
                                </svg>
                                Mes aspirations
                            </h3>
                            <p class="text-gray-300 text-[16px] leading-relaxed">
                                je suis trés polyvalent dans differents domaine et donc mon but premier est de devenir developpeur Python
                            </p>
                        </div>
                    </div>

                    <!-- Ce que je fais -->
                    <div class="flex-1 bg-white/5 backdrop-blur-sm rounded-2xl p-8 border border-white/10 hover:border-[#0FDBD0]/50 transition-all duration-300">
                        <h3 class="text-2xl font-bold text-white mb-6 flex items-center gap-3">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                                stroke="currentColor" class="w-7 h-7 text-[#0FDBD0]">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                    d="M17.25 6.75 22.5 12l-5.25 5.25m-10.5 0L1.5 12l5.25-5.25m7.5-3-4.5 16.5" />
                            </svg>
                            Ce que je fais
                        </h3>

                                               <!-- Slider de compétences -->
                        <div class="relative overflow-hidden">
                            <!-- Conteneur des slides -->
                            <div class="relative h-[650px]">
                                <div v-for="(skill, index) in skills" :key="index"
                                    :class="['absolute inset-0 transition-all duration-700 ease-in-out transform', 
                                        currentSkill === index ? 'translate-x-0 opacity-100' : 
                                        currentSkill < index ? 'translate-x-full opacity-0' : '-translate-x-full opacity-0']">
                                    
                                    <!-- Card de compétence -->
                                    <div class="bg-gradient-to-br from-[#0FDBD0]/10 to-transparent rounded-xl p-5 h-full border border-[#0FDBD0]/20 overflow-y-auto">
                                        <!-- Titre avec emoji -->
                                        <div class="flex items-center gap-3 mb-4 pb-3 border-b border-white/10">
                                            <span class="text-3xl">{{ skill.emoji }}</span>
                                            <h4 class="text-xl font-bold text-white">{{ skill.title }}</h4>
                                        </div>
                                        
                                        <!-- Liste des compétences -->
                                        <ul class="space-y-2.5 text-gray-300">
                                            <li v-for="(item, i) in skill.items" :key="i" 
                                                class="flex items-start gap-3 animate-slide-in"
                                                :style="{ animationDelay: `${i * 0.1}s` }">
                                                <span class="text-[#0FDBD0] text-lg mt-1 flex-shrink-0">✓</span>
                                                <span class="text-[15px]" v-html="item"></span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <!-- Indicateurs et navigation -->
                            <div class="mt-6 flex items-center justify-between">
                                <!-- Boutons de navigation -->
                                <button @click="handleManualNavigation(previousSkill)" 
                                    class="p-3 rounded-full bg-[#0FDBD0] hover:bg-[#0FDBD0]/80 transition-all duration-300 hover:scale-110 shadow-lg">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2.5" 
                                        stroke="currentColor" class="w-6 h-6 text-white">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" />
                                    </svg>
                                </button>

                                <!-- Dots indicateurs -->
                                <div class="flex gap-2">
                                    <button v-for="(skill, index) in skills" :key="index"
                                        @click="handleManualNavigation(() => currentSkill = index)"
                                        :class="['h-3 rounded-full transition-all duration-300', 
                                            currentSkill === index ? 'w-10 bg-[#0FDBD0]' : 'w-3 bg-white/50 hover:bg-white/70']">
                                    </button>
                                </div>

                                <button @click="handleManualNavigation(nextSkill)" 
                                    class="p-3 rounded-full bg-[#0FDBD0] hover:bg-[#0FDBD0]/80 transition-all duration-300 hover:scale-110 shadow-lg">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2.5" 
                                        stroke="currentColor" class="w-6 h-6 text-white">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" />
                                    </svg>
                                </button>
                            </div>

                            <!-- Compteur -->
                            <div class="text-center mt-4">
                                <span class="text-sm text-gray-400">
                                    {{ currentSkill + 1 }} / {{ skills.length }}
                                </span>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </section>
    </div>

    <!-- Section Projets Réalisés -->
    <section id="projet" class="min-h-screen bg-gray-50 py-20 px-6 z-45">
        <div class="max-w-7xl mx-auto">

            <!-- Titre de la section -->
            <div class="text-center mb-16 animate-fade-in">
                <h2 class="text-5xl md:text-6xl font-bold text-gray-900 mb-4">
                    Mes <span class="text-red-500">Projets</span>
                </h2>
                <div class="w-24 h-1 bg-red-500 mx-auto rounded-full"></div>
                <p class="text-gray-600 mt-6 text-lg max-w-2xl mx-auto">
                    Découvrez une sélection de mes réalisations récentes en développement web
                </p>
            </div>

            <!-- Grille de projets -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">

                <!-- Projet 1 -->
                <div
                    class="group bg-white rounded-2xl overflow-hidden  transition-all duration-500 hover:-translate-y-2">

                    <!-- Image du projet -->
                    <div class="relative h-64 overflow-hidden bg-gradient-to-br from-blue-500 to-purple-600">
                        <img src="./../assets/image/educpay.png" alt="Educpay - Gestion de paie scolaire"
                            class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-500" />

                        <!-- Overlay au survol -->
                        <div
                            class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/40 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-end p-6">
                            <div class="flex gap-3">
                                <a href="https://educpay.omegaconsulting-services.com/"
                                    class="bg-red-400 text-white px-4 py-2 rounded-lg font-semibold hover:bg-[#0FDBD0]/90 transition-all text-sm flex items-center gap-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                        stroke-width="2" stroke="currentColor" class="w-4 h-4">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                                    </svg>
                                    Démo
                                </a>
                                <a href="#"
                                    class="bg-white/20 backdrop-blur-sm text-white px-4 py-2 rounded-lg font-semibold hover:bg-white/30 transition-all text-sm flex items-center gap-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                        stroke-width="2" stroke="currentColor" class="w-4 h-4">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M17.25 6.75 22.5 12l-5.25 5.25m-10.5 0L1.5 12l5.25-5.25m7.5-3-4.5 16.5" />
                                    </svg>
                                    Code
                                </a>
                            </div>
                        </div>

                        <!-- Badge de statut -->
                        <div
                            class="absolute top-4 right-4 bg-green-500 text-white px-3 py-1 rounded-full text-xs font-semibold flex items-center gap-1">
                            <div class="w-2 h-2 bg-white rounded-full animate-pulse"></div>
                            En Production
                        </div>
                    </div>

                    <!-- Contenu du projet -->
                    <div class="p-6">
                        <h3 class="text-2xl font-bold text-gray-900 mb-2 group-hover:text-[#0FDBD0] transition-colors">
                            Educpay
                        </h3>
                        <p class="text-gray-600 mb-4 text-[15px] leading-relaxed">
                            Educpay est une plateforme de gestion de paie scolaire qui simplifie le processus de paiement des frais scolaires pour les parents dans les établissements.
                        </p>

                        <!-- Technologies utilisées -->
                        <div class="flex flex-wrap gap-2 mb-4">
                            <span
                                class="bg-blue-100 text-blue-700 px-3 py-1 rounded-full text-xs font-semibold">Vue.js</span>
                                 <span
                                class="bg-blue-200 text-blue-700 px-3 py-1 rounded-full text-xs font-semibold">Tailwind</span>


                            <span
                                class="bg-cyan-100 text-cyan-700 px-3 py-1 rounded-full text-xs font-semibold">Django Rest</span>
                        </div>

                        <!-- Footer avec icônes -->
                        <div class="flex items-center justify-between pt-4 border-t border-gray-100">
                            <div class="flex items-center gap-2 text-gray-500 text-sm">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                    stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 0 1 2.25-2.25h13.5A2.25 2.25 0 0 1 21 7.5v11.25m-18 0A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75m-18 0v-7.5A2.25 2.25 0 0 1 5.25 9h13.5A2.25 2.25 0 0 1 21 11.25v7.5" />
                                </svg>
                                2025
                            </div>
                            <a href="#contact"
                                class="text-[#0FDBD0] hover:text-[#0FDBD0]/80 font-semibold text-sm flex items-center gap-1">
                                En savoir plus
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2"
                                    stroke="currentColor" class="w-4 h-4">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M13.5 4.5 21 12m0 0-7.5 7.5M21 12H3" />
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>
                <!-- Projet 2 -->
                <div
                    class="group bg-white rounded-2xl overflow-hidden shadow-lg hover:shadow-2xl transition-all duration-500 hover:-translate-y-2">

                    <!-- Image du projet -->
                    <div class="relative h-64 overflow-hidden bg-gradient-to-br from-blue-500 to-purple-600">
                        <img src="./../assets/image/sgstock.png" alt="SG-Stock - Gestion de stock"
                            class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-500" />

                        <!-- Overlay au survol -->
                        <div
                            class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/40 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-end p-6">
                            <div class="flex gap-3">
                                <a href="https://sg-stocks.com/"
                                    class="bg-[#0FDBD0] text-gray-900 px-4 py-2 rounded-lg font-semibold hover:bg-[#0FDBD0]/90 transition-all text-sm flex items-center gap-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                        stroke-width="2" stroke="currentColor" class="w-4 h-4">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                                    </svg>
                                    Démo
                                </a>
                                <a href="#"
                                    class="bg-white/20 backdrop-blur-sm text-white px-4 py-2 rounded-lg font-semibold hover:bg-white/30 transition-all text-sm flex items-center gap-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                        stroke-width="2" stroke="currentColor" class="w-4 h-4">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M17.25 6.75 22.5 12l-5.25 5.25m-10.5 0L1.5 12l5.25-5.25m7.5-3-4.5 16.5" />
                                    </svg>
                                    Code
                                </a>
                            </div>
                        </div>

                        <!-- Badge de statut -->
                        <div
                            class="absolute top-4 right-4 bg-green-500 text-white px-3 py-1 rounded-full text-xs font-semibold flex items-center gap-1">
                            <div class="w-2 h-2 bg-white rounded-full animate-pulse"></div>
                            En developpement
                        </div>
                    </div>

                    <!-- Contenu du projet -->
                    <div class="p-6">
                        <h3 class="text-2xl font-bold text-gray-900 mb-2 group-hover:text-[#0FDBD0] transition-colors">
                            SG-Stock
                        </h3>
                        <p class="text-gray-600 mb-4 text-[15px] leading-relaxed">
                            Application de gestion de stock complète avec tableau de bord, gestion des produits,
                            alertes de rupture et rapports détaillés.
                        </p>

                        <!-- Technologies utilisées -->
                        <div class="flex flex-wrap gap-2 mb-4">
                            <span class="bg-blue-100 text-blue-700 px-3 py-1 rounded-full text-xs font-semibold"><span class="font-bold tex-[20px]"> Vue.js</span></span>
                            <span class="bg-purple-100 text-green-400 px-3 py-1 rounded-full text-xs font-semibold">Django rest</span>
                            <span class="bg-purple-100 text-pink-700 px-3 py-1 rounded-full text-xs font-semibold">Daphne</span>
                            <span class="bg-purple-100 text-gray-500 px-3 py-1 rounded-full text-xs font-semibold">Figma</span>
                            <span class="bg-purple-100 text-purple-700 px-3 py-1 rounded-full text-xs font-semibold">Postgres sql</span>
                        </div>

                        <!-- Footer avec icônes -->
                        <div class="flex items-center justify-between pt-4 border-t border-gray-100">
                            <div class="flex items-center gap-2 text-gray-500 text-sm">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                    stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 0 1 2.25-2.25h13.5A2.25 2.25 0 0 1 21 7.5v11.25m-18 0A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75m-18 0v-7.5A2.25 2.25 0 0 1 5.25 9h13.5A2.25 2.25 0 0 1 21 11.25v7.5" />
                                </svg>
                                2025-2026 @Copright
                            </div>

                        </div>
                    </div>
                </div>

                <!-- Projet 3 -->
                <div
                    class="group bg-white rounded-2xl overflow-hidden shadow-lg hover:shadow-2xl transition-all duration-500 hover:-translate-y-2">

                    <div class="relative h-64 overflow-hidden bg-gradient-to-br from-pink-500 to-orange-600">
                        <img src="./../assets/image/negoce.png" alt="Portfolio personnel"
                            class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-500" />

                        <div
                            class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/40 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-end p-6">
                            <div class="flex gap-3">
                                <a href="https://negoce-cacao.com/"
                                    class="bg-[#0FDBD0] text-gray-900 px-4 py-2 rounded-lg font-semibold hover:bg-[#0FDBD0]/90 transition-all text-sm flex items-center gap-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                        stroke-width="2" stroke="currentColor" class="w-4 h-4">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                                    </svg>
                                    Démo
                                </a>
                                <a href="#"
                                    class="bg-white/20 backdrop-blur-sm text-white px-4 py-2 rounded-lg font-semibold hover:bg-white/30 transition-all text-sm flex items-center gap-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                        stroke-width="2" stroke="currentColor" class="w-4 h-4">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M17.25 6.75 22.5 12l-5.25 5.25m-10.5 0L1.5 12l5.25-5.25m7.5-3-4.5 16.5" />
                                    </svg>
                                    Code
                                </a>
                            </div>
                        </div>

                        <div
                            class="absolute top-4 right-4 bg-green-500 text-white px-3 py-1 rounded-full text-xs font-semibold flex items-center gap-1">
                            <div class="w-2 h-2 bg-white rounded-full animate-pulse"></div>
                            En ligne
                        </div>
                    </div>

                    <div class="p-6">
                        <h3 class="text-2xl font-bold text-gray-900 mb-2 group-hover:text-[#0FDBD0] transition-colors">
                            Negoce Cameroun Cacao
                        </h3>
                        <p class="text-gray-600 mb-4 text-[15px] leading-relaxed">
                            COMMUNAUTE
Nous sommes un négociant entre les sociétés coopératives et GiC (groupes d'initiatives communes) producteurs de cacao/café et les sociétés ayant pour matière première le cacao ou le café.
                        </p>

                        <div class="flex flex-wrap gap-2 mb-4">
                            <span
                                class="bg-blue-100 text-blue-700 px-3 py-1 rounded-full text-xs font-semibold">Vue.js</span>
                            <span
                                class="bg-cyan-100 text-cyan-700 px-3 py-1 rounded-full text-xs font-semibold">Tailwind</span>
                           
                        </div>

                        <div class="flex items-center justify-between pt-4 border-t border-gray-100">
                            <div class="flex items-center gap-2 text-gray-500 text-sm">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                    stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 0 1 2.25-2.25h13.5A2.25 2.25 0 0 1 21 7.5v11.25m-18 0A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75m-18 0v-7.5A2.25 2.25 0 0 1 5.25 9h13.5A2.25 2.25 0 0 1 21 11.25v7.5" />
                                </svg>
                                2024
                            </div>
                            <a href="#contact"
                                class="text-[#0FDBD0] hover:text-[#0FDBD0]/80 font-semibold text-sm flex items-center gap-1">
                                En savoir plus
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2"
                                    stroke="currentColor" class="w-4 h-4">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M13.5 4.5 21 12m0 0-7.5 7.5M21 12H3" />
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Projet 3 -->
                <div
                    class="group bg-white rounded-2xl overflow-hidden shadow-lg hover:shadow-2xl transition-all duration-500 hover:-translate-y-2">

                    <div class="relative h-64 overflow-hidden bg-gradient-to-br from-green-500 to-teal-600">
                        <img src="./../assets/image/omega.png"
                            alt="Entreprise specialiser dans des solution digital"
                            class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-500" />

                        <div
                            class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/40 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-end p-6">
                            <div class="flex gap-3">
                                <a href="https://omegaconsulting-services.com/"
                                    class="bg-[#0FDBD0] text-gray-900 px-4 py-2 rounded-lg font-semibold hover:bg-[#0FDBD0]/90 transition-all text-sm flex items-center gap-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                        stroke-width="2" stroke="currentColor" class="w-4 h-4">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                                    </svg>
                                    Démo
                                </a>
                                <a href="#"
                                    class="bg-white/20 backdrop-blur-sm text-white px-4 py-2 rounded-lg font-semibold hover:bg-white/30 transition-all text-sm flex items-center gap-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                        stroke-width="2" stroke="currentColor" class="w-4 h-4">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M17.25 6.75 22.5 12l-5.25 5.25m-10.5 0L1.5 12l5.25-5.25m7.5-3-4.5 16.5" />
                                    </svg>
                                    Code
                                </a>
                            </div>
                        </div>

                        <div
                            class="absolute top-4 right-4 bg-yellow-500 text-white px-3 py-1 rounded-full text-xs font-semibold">
                            En ligne
                        </div>
                    </div>

                    <div class="p-6">
                        <h3 class="text-2xl font-bold text-gray-900 mb-2 group-hover:text-[#0FDBD0] transition-colors">
                            Startup informatique
                        </h3>
                        <p class="text-gray-600 mb-4 text-[15px] leading-relaxed">
                             startup est spécialisée dans la conception et la réalisation des sites internet et applications mobiles sur mesure, adaptés aux besoins uniques de nos clients.
                        </p>

                        <div class="flex flex-wrap gap-2 mb-4">
                            <span
                                class="bg-blue-100 text-blue-700 px-3 py-1 rounded-full text-xs font-semibold">Vue.js</span>
                            <span
                                class="bg-green-100 text-green-700 px-3 py-1 rounded-full text-xs font-semibold">Django</span>
                            
                            <span
                                class="bg-cyan-100 text-cyan-700 px-3 py-1 rounded-full text-xs font-semibold">Tailwind</span>
                        </div>

                        <div class="flex items-center justify-between pt-4 border-t border-gray-100">
                            <div class="flex items-center gap-2 text-gray-500 text-sm">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                    stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 0 1 2.25-2.25h13.5A2.25 2.25 0 0 1 21 7.5v11.25m-18 0A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75m-18 0v-7.5A2.25 2.25 0 0 1 5.25 9h13.5A2.25 2.25 0 0 1 21 11.25v7.5" />
                                </svg>
                                2024
                            </div>
                            <a href="#contact"
                                class="text-[#0FDBD0] hover:text-[#0FDBD0]/80 font-semibold text-sm flex items-center gap-1">
                                En savoir plus
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2"
                                    stroke="currentColor" class="w-4 h-4">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M13.5 4.5 21 12m0 0-7.5 7.5M21 12H3" />
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>


                <!-- Projet 3 -->
                <div
                    class="group bg-white rounded-2xl overflow-hidden shadow-lg hover:shadow-2xl transition-all duration-500 hover:-translate-y-2">

                    <div class="relative h-64 overflow-hidden bg-gradient-to-br from-pink-500 to-orange-600">
                        <img src="./../assets/image/agribio.png" alt="Portfolio personnel"
                            class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-500" />

                        <div
                            class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/40 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-end p-6">
                            <div class="flex gap-3">
                                <a href="https://www.agribio-future.com/"
                                    class="bg-[#0FDBD0] text-gray-900 px-4 py-2 rounded-lg font-semibold hover:bg-[#0FDBD0]/90 transition-all text-sm flex items-center gap-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                        stroke-width="2" stroke="currentColor" class="w-4 h-4">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                                    </svg>
                                    Démo
                                </a>
                                <a href="#"
                                    class="bg-white/20 backdrop-blur-sm text-white px-4 py-2 rounded-lg font-semibold hover:bg-white/30 transition-all text-sm flex items-center gap-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                        stroke-width="2" stroke="currentColor" class="w-4 h-4">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M17.25 6.75 22.5 12l-5.25 5.25m-10.5 0L1.5 12l5.25-5.25m7.5-3-4.5 16.5" />
                                    </svg>
                                    Code
                                </a>
                            </div>
                        </div>

                        <div
                            class="absolute top-4 right-4 bg-green-500 text-white px-3 py-1 rounded-full text-xs font-semibold flex items-center gap-1">
                            <div class="w-2 h-2 bg-white rounded-full animate-pulse"></div>
                            En ligne
                        </div>
                    </div>

                    <div class="p-6">
                        <h3 class="text-2xl font-bold text-gray-900 mb-2 group-hover:text-[#0FDBD0] transition-colors">
                            Agri bio Future
                        </h3>
                        <p class="text-gray-600 mb-4 text-[15px] leading-relaxed">
                            Produits 
                            Agribio Future sarl, nous nous engageons à fournir des solutions de fertilisation de haute qualité pour maximiser la productivité de vos cultures.
                            Forts de plusieurs années d'expérience dans le domaine, nous sommes fiers d'être un leader dans la production et la commercialisation d'engrais chimiques.
                        </p>

                        <div class="flex flex-wrap gap-2 mb-4">
                            <span
                                class="bg-blue-100 text-blue-700 px-3 py-1 rounded-full text-xs font-semibold">Vue.js</span>
                            <span
                                class="bg-cyan-100 text-cyan-700 px-3 py-1 rounded-full text-xs font-semibold">Tailwind</span>
                           
                        </div>

                        <div class="flex items-center justify-between pt-4 border-t border-gray-100">
                            <div class="flex items-center gap-2 text-gray-500 text-sm">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                    stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 0 1 2.25-2.25h13.5A2.25 2.25 0 0 1 21 7.5v11.25m-18 0A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75m-18 0v-7.5A2.25 2.25 0 0 1 5.25 9h13.5A2.25 2.25 0 0 1 21 11.25v7.5" />
                                </svg>
                                2024
                            </div>
                            <a href="#contact"
                                class="text-[#0FDBD0] hover:text-[#0FDBD0]/80 font-semibold text-sm flex items-center gap-1">
                                En savoir plus
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2"
                                    stroke="currentColor" class="w-4 h-4">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M13.5 4.5 21 12m0 0-7.5 7.5M21 12H3" />
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>

            </div>

            <!-- CTA en bas de section -->
            <div class="text-center mt-16">
                <p class="text-gray-600 mb-6 text-lg">
                    Cliquez sur le bouton pour consulter mes projets en Design graphique
                </p>
                <a href="https://ralphsengue.wixsite.com/ralph-designs"
                    class="inline-flex items-center gap-2 bg-[#0FDBD0] text-gray-900 px-8 py-4 rounded-lg font-semibold hover:bg-[#0FDBD0]/90 transition-all duration-300 hover:scale-105 hover:shadow-lg hover:shadow-[#0FDBD0]/50">
                    Travaillons ensemble
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2"
                        stroke="currentColor" class="w-5 h-5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M13.5 4.5 21 12m0 0-7.5 7.5M21 12H3" />
                    </svg>
                </a>
            </div>

        </div>
    </section>
    <section id="contact">
        <footer class="w-full bg-gray-100 p-4 md:p-6">
            <section class="max-w-4xl mx-auto bg-white rounded-lg shadow-sm p-6 md:p-10">
                <!-- Titre -->
                <div class="text-center mb-8">
                    <h2 class="text-[#1F2937] text-2xl md:text-3xl lg:text-4xl font-bold leading-tight">
                        Contactez-nous
                    </h2>
                    <div class="w-24 h-1 bg-[#0FDBD0] mx-auto rounded-full mt-3"></div>
                </div>

                <!-- Formulaire -->
                <form class="max-w-2xl mx-auto space-y-5">
                    <!-- Nom et prénom -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div class="relative">
                            <input type="text" placeholder="First Name*"
                                class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-blue-500 focus:outline-none transition-colors duration-200 placeholder-gray-400"
                                required />
                        </div>
                        <div class="relative">
                            <input type="text" placeholder="Email*"
                                class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-blue-500 focus:outline-none transition-colors duration-200 placeholder-gray-400"
                                required />
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="relative">
                        <input type="email" placeholder="Votre numéro de téléphone*"
                            class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-blue-500 focus:outline-none transition-colors duration-200 placeholder-gray-400"
                            required />
                    </div>

                    <!-- Phone -->
                    <div class="relative">
                        <input type="tel" placeholder="Nom de votre projet :*"
                            class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-blue-500 focus:outline-none transition-colors duration-200 placeholder-gray-400"
                            required />
                    </div>

                    <!-- Message -->
                    <div class="relative">
                        <textarea type="text" placeholder="Descrivez nous votre  projet...." rows="5"
                            class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-blue-500 focus:outline-none transition-colors duration-200 placeholder-gray-400 resize-none"
                            required></textarea>
                    </div>

                    <!-- Bouton d'envoi -->
                    <button type="submit"
                        class="w-full bg-[#1E293B] text-white py-3.5 px-6 rounded-lg font-semibold hover:bg-[#0F172A] transition-colors duration-200">
                        Send Message
                    </button>


                </form>
            </section>
        </footer>
        <footer class="w-full bg-[#000000] text-white py-12">
            <div class="max-w-7xl mx-auto px-4 md:px-6">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8 md:gap-12 mb-8 md:mb-12">
                    <!-- Logo et description -->
                    <div class="space-y-4 flex flex-col items-center md:items-start text-center md:text-left">
                        <div class=" w-3/3 ">
                            <img src="./../assets/image/Sengue dev.png" alt="mon logo" class="text-white w-full h-auto">
                        </div>

                        <div class="flex gap-3 justify-center md:justify-start">
                            <a href="#"
                                class="w-9 h-9 bg-white/10 hover:bg-[#0EA5E9] rounded-full flex items-center justify-center transition-all duration-300 hover:scale-110"
                                aria-label="Facebook">
                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                                    <path
                                        d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z" />
                                </svg>
                            </a>
                            <a href="#"
                                class="w-9 h-9 bg-white/10 hover:bg-[#0EA5E9] rounded-full flex items-center justify-center transition-all duration-300 hover:scale-110"
                                aria-label="Twitter">
                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                                    <path
                                        d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z" />
                                </svg>
                            </a>
                            <a href="#"
                                class="w-9 h-9 bg-white/10 hover:bg-[#0EA5E9] rounded-full flex items-center justify-center transition-all duration-300 hover:scale-110"
                                aria-label="LinkedIn">
                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                                    <path
                                        d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z" />
                                </svg>
                            </a>
                        </div>
                    </div>

                    <!-- Services -->
                    <div class="space-y-4 text-center md:text-left">
                        <h3 class="text-base md:text-lg font-bold text-white">Services</h3>
                        <ul class="space-y-3 text-gray-400 text-sm">
                            <li>
                                <a href="#"
                                    class="hover:text-[#0EA5E9] transition-colors inline-block hover:translate-x-1 duration-300">
                                    Design UI/UX
                                </a>
                            </li>
                            <li>
                                <a href="#"
                                    class="hover:text-[#0EA5E9] transition-colors inline-block hover:translate-x-1 duration-300">
                                    Développement web front-end
                                </a>
                            </li>
                            <li>
                                <a href="#"
                                    class="hover:text-[#0EA5E9] transition-colors inline-block hover:translate-x-1 duration-300">
                                    Développement web backend
                                </a>
                            </li>
                        </ul>
                    </div>

                    <!-- Contact Info -->
                    <div class="space-y-4 text-center md:text-left">
                        <h3 class="text-base md:text-lg font-bold text-white">Contact Info</h3>
                        <ul class="space-y-3 text-gray-400 text-sm">
                            <li class="flex items-center gap-2 justify-center md:justify-start">
                                <svg class="w-4 h-4 text-[#0EA5E9] flex-shrink-0" fill="currentColor"
                                    viewBox="0 0 20 20">
                                    <path
                                        d="M2 3a1 1 0 011-1h2.153a1 1 0 01.986.836l.74 4.435a1 1 0 01-.54 1.06l-1.548.773a11.037 11.037 0 006.105 6.105l.774-1.548a1 1 0 011.059-.54l4.435.74a1 1 0 01.836.986V17a1 1 0 01-1 1h-2C7.82 18 2 12.18 2 5V3z" />
                                </svg>
                                <a href="tel:+237652263517" class="hover:text-[#0EA5E9] transition-colors">
                                    +237 6 52 26 35 17
                                </a>
                            </li>
                            <li class="flex items-center gap-2 justify-center md:justify-start">
                                <svg class="w-4 h-4 text-[#0EA5E9] flex-shrink-0" fill="currentColor"
                                    viewBox="0 0 20 20">
                                    <path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z" />
                                    <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z" />
                                </svg>
                                <a href="mailto:info@leogicom.com" class="hover:text-[#0EA5E9] transition-colors">
                                    ralphsengue@gmail.com
                                </a>
                            </li>
                            <li class="flex items-center gap-2 justify-center md:justify-start">
                                <svg class="w-4 h-4 text-[#0EA5E9] flex-shrink-0" fill="currentColor"
                                    viewBox="0 0 20 20">
                                    <path fill-rule="evenodd"
                                        d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z"
                                        clip-rule="evenodd" />
                                </svg>
                                <span>Douala, Cameroun</span>
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Copyright -->
                <div class="pt-6 md:pt-8 border-t border-gray-800 text-center">
                    <p class="text-gray-500 text-xs md:text-sm">
                        © 2025 All rights reserved.
                    </p>
                </div>
            </div>
        </footer>
    </section>

</template>

<script setup>
import { onMounted, onBeforeUnmount, ref } from "vue";

const isMenuOpen = ref(false)

const closeMenu = () => {
    isMenuOpen.value = false
}

// Slider de compétences
const currentSkill = ref(0)

const skills = ref([
    {
        emoji: '💻',
        title: 'Développement Backend',
        items: [
            'Analyse et Conception des systèmes d\'information avec <strong class="text-white">Analyse SI</strong> et <strong class="text-white">Star UML</strong>',
            'Concevoir l\'architecture backend d\'une application',
            'Gérer l\'authentification et l\'autorisation (JWT, OAuth, rôles)',
            'Mettre en place des systèmes multi-tenant',
            'Développer des API REST avec <strong class="text-white">Django Rest Framework</strong>',
            'Transformer un besoin métier en modules fonctionnels',
            'Travail en équipe avec <strong class="text-white">Git</strong>',
            'Gestion des projets avec <strong class="text-white">Jira</strong> et <strong class="text-white">Confluence</strong>',
            'Gestion de bases de données <strong class="text-white">MySQL</strong> et optimisation des performances',
            'Intégration et déploiement continu sur <strong class="text-white">Hostinger</strong> (VPS CyberPanel)'
        ]
    },
    {
        emoji: '🎨',
        title: 'Design & Création',
        items: [
            'Conception d\'interfaces utilisateur modernes',
            'Création de chartes graphiques',
            'Design de supports de communication',
            'Prototypage et wireframing',
            'UX/UI Design pour applications web et mobiles',
            'Création de contenus visuels pour les réseaux sociaux'
        ]
    },
    {
        emoji: '📱',
        title: 'Community Management',
        items: [
            'Gérer des pages et communautés sur les réseaux sociaux',
            'Créer des calendriers éditoriaux',
            'Produire des contenus visuels et textuels',
            'Analyser les performances (engagement, portée, croissance)',
            'Interagir avec la communauté (messages, commentaires)',
            'Mettre en place des stratégies de visibilité et de branding'
        ]
    },
    {
        emoji: '🔄',
        title: 'Polyvalence & Collaboration',
        items: [
            'Collaborer avec des développeurs frontend',
            'Travailler avec des équipes marketing',
            'Assurer la cohérence entre technique, design et communication',
            'Former ou accompagner des utilisateurs/clients',
            'Gérer des projets digitaux de bout en bout'
        ]
    },
    {
        emoji: '💼',
        title: 'Types de missions possibles',
        items: [
            'Développement d\'API pour applications web et mobiles',
            'Création de solutions SaaS',
            'Refonte technique et visuelle de produits existants',
            'Gestion de l\'image digitale d\'une marque ou startup',
            'Freelance / Consultant technique & digital',
            'Lead technique pour petits projets'
        ]
    },
    
])

const nextSkill = () => {
    currentSkill.value = (currentSkill.value + 1) % skills.value.length
}

const previousSkill = () => {
    currentSkill.value = currentSkill.value === 0 ? skills.value.length - 1 : currentSkill.value - 1
}

// Auto-défilement du slider
let autoSlideInterval = null

const startAutoSlide = () => {
    autoSlideInterval = setInterval(() => {
        nextSkill()
    }, 4000) // Change de slide toutes les 4 secondes
}

const stopAutoSlide = () => {
    if (autoSlideInterval) {
        clearInterval(autoSlideInterval)
    }
}

const handleManualNavigation = (action) => {
    stopAutoSlide()
    action()
    startAutoSlide() // Redémarre l'auto-défilement après navigation manuelle
}


const vantaRef = ref(null);

const vantaRef1 = ref(null);
let vantaEffect = null;
let vantaEffect1 = null;


onMounted(() => {
    // Démarre l'auto-défilement du slider
    startAutoSlide()
    
    if (window.VANTA) {
        vantaEffect = window.VANTA.DOTS({
            el: vantaRef.value,
            mouseControls: true,
            touchControls: true,
            gyroControls: false,
            minHeight: 200.0,
            minWidth: 200.0,
            scale: 1.0,
            scaleMobile: 1.0,
            color: 0xe3458f,
            color2: 0x4a4ab1,
            backgroundColor: 0x2e,
            size: 5.0,
            spacing: 29.0,
            showLines: false
        });
            vantaEffect1 = window.VANTA.DOTS({
            el: vantaRef1.value,
            mouseControls: true,
            touchControls: true,
            gyroControls: false,
            minHeight: 200.0,
            minWidth: 200.0,
            scale: 1.0,
            scaleMobile: 1.0,
            color: 0x4d45e3,
            color2: 0x4a4ab1,
            backgroundColor: 0x20204,
            size: 5.0,
            spacing: 29.0,
            showLines: false
        });
    }
});

onBeforeUnmount(() => {
    stopAutoSlide() // Arrête l'auto-défilement
    if (vantaEffect) vantaEffect.destroy(); // Nettoyage pour éviter les fuites mémoire
});
</script>
<style scoped>
/* Empêcher le scroll quand le menu mobile est ouvert */
body:has(.mobile-menu-open) {
    overflow: hidden;
}

/* Animation personnalisée pour le pouls de la bordure */
@keyframes pulse {

    0%,
    100% {
        opacity: 1;
        transform: scale(1);
    }

    50% {
        opacity: 0.7;
        transform: scale(1.02);
    }
}

.animate-pulse {
    animation: pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}

/* Animation pour les items de compétences */
@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateX(-20px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

.animate-slide-in {
    animation: slideIn 0.5s ease-out forwards;
    opacity: 0;
}
</style>