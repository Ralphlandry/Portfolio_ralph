<template>
  <div class="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100">
    <!-- Header -->
    <header class="bg-[#000A2B] w-full h-20 flex justify-between items-center px-6 lg:px-12 fixed top-0 z-50 shadow-lg">
      <div class="flex gap-2 text-2xl lg:text-3xl">
        <h1 class="font-bold text-white">Marie</h1>
        <h1 class="font-bold text-[#0FDBD0]">Shalice</h1>
      </div>

      <!-- Desktop Menu -->
      <nav class="hidden md:flex text-white gap-8 ">
        <button
          v-for="item in menuItems"
          :key="item"
          @click="scrollToSection(item)"
          :class="[
            'hover:text-[#0FDBD0] transition-all duration-300 hover:scale-105',
            activeSection === item.toLowerCase() && 'text-[#0FDBD0]'
          ]"
        >
          {{ item }}
        </button>
      </nav>

      <!-- Mobile Menu Button -->
      <button
        class="md:hidden text-white hover:text-[#0FDBD0] transition-colors"
        @click="isMenuOpen = !isMenuOpen"
      >
        <svg v-if="!isMenuOpen" class="w-7 h-7" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
        </svg>
        <svg v-else class="w-7 h-7" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
        </svg>
      </button>
    </header>

    <!-- Mobile Menu -->
    <Transition
      enter-active-class="transition duration-300 ease-out"
      enter-from-class="opacity-0 -translate-y-4"
      enter-to-class="opacity-100 translate-y-0"
      leave-active-class="transition duration-200 ease-in"
      leave-from-class="opacity-100 translate-y-0"
      leave-to-class="opacity-0 -translate-y-4"
    >
      <div v-if="isMenuOpen" class="fixed top-20 left-0 w-full bg-[#000A2B] z-40 md:hidden shadow-xl">
        <nav class="flex flex-col text-white p-6 gap-4">
          <button
            v-for="item in menuItems"
            :key="item"
            @click="scrollToSection(item)"
            class="text-left hover:text-[#0FDBD0] transition-colors py-2 border-b border-slate-700"
          >
            {{ item }}
          </button>
        </nav>
      </div>
    </Transition>

    <!-- Hero Section -->
    <section id="accueil" class="pt-32 pb-20 px-6 lg:px-12">
      <div class="max-w-6xl mx-auto">
        <div class="flex flex-col lg:flex-row items-center gap-12">
          <div class="flex-1 text-center lg:text-left">
            <h2 class="text-4xl lg:text-6xl font-bold text-[#000A2B] mb-4 leading-tight">
              Bonjour, je suis <span class="text-[#0FDBD0]">Marie Shalice</span>
            </h2>
            <p class="text-xl lg:text-2xl text-slate-600 mb-3">
              Développeuse Fullstack en devenir
            </p>
            <p class="text-lg text-slate-500 mb-8">
              Passionnée par le web et le design
            </p>
            <div class="flex gap-4 justify-center lg:justify-start flex-wrap">
              <button
                @click="scrollToSection('Projets')"
                class="bg-[#0FDBD0] text-[#000A2B] font-semibold text-lg py-3 px-8 rounded-lg hover:bg-[#0ac5bb] transition-all duration-300 hover:scale-105 shadow-lg hover:shadow-xl"
              >
                Voir mes projets
              </button>
              <button
                @click="scrollToSection('Contact')"
                class="bg-white text-[#000A2B] font-semibold text-lg py-3 px-8 rounded-lg hover:bg-slate-100 transition-all duration-300 border-2 border-[#000A2B]"
              >
                Me contacter
              </button>
            </div>
          </div>
          <div class="flex-1 flex justify-center">
            <!-- <div class="relative">
              <div class="w-64 h-64 lg:w-80 lg:h-80 bg-gradient-to-br from-[#0FDBD0] to-[#000A2B] rounded-full flex items-center justify-center shadow-2xl animate-pulse-slow">
                <div class="text-white text-6xl lg:text-8xl">
                    
                </div>
              </div>
              <div class="absolute -bottom-4 -right-4 bg-white p-4 rounded-lg shadow-xl">
                <svg class="w-8 h-8 text-[#0FDBD0]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4" />
                </svg>
              </div>
            </div> -->
                <div class="w-[350px] h-[350px] rounded-full">
                    <img src="./../assets/image/Screenshot_20251107_171440_WhatsApp.jpg" alt="" class="rounded-full w-[350px] h-[350px]">
                </div>
        </div>
        </div>
      </div>
    </section>

    <!-- About Section -->
    <section id="à propos" class="py-20 px-6 lg:px-12 bg-white">
      <div class="max-w-6xl mx-auto">
        <h2 class="text-4xl font-bold text-center text-[#000A2B] mb-12">À propos de moi</h2>
        <div class="grid md:grid-cols-3 gap-8">
          <div
            v-for="(card, index) in aboutCards"
            :key="index"
            class="bg-gradient-to-br from-slate-50 to-slate-100 p-8 rounded-xl shadow-lg hover:shadow-xl transition-all duration-300 hover:-translate-y-2"
          >
            <div class="bg-[#0FDBD0] w-16 h-16 rounded-full flex items-center justify-center mb-4">
              <component :is="card.icon" class="w-8 h-8 text-[#000A2B]" />
            </div>
            <h3 class="text-xl font-bold text-[#000A2B] mb-3">{{ card.title }}</h3>
            <p class="text-slate-600">{{ card.description }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Projects Section -->
    <section id="projets" class="py-20 px-6 lg:px-12">
      <div class="max-w-6xl mx-auto">
        <h2 class="text-4xl font-bold text-center text-[#000A2B] mb-12">Mes Projets</h2>
        <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div
            v-for="(project, index) in projects"
            :key="index"
            class="bg-white rounded-xl overflow-hidden shadow-lg hover:shadow-2xl transition-all duration-300 hover:-translate-y-2"
          >
            <img :src="project.image" :alt="project.title" class="w-full h-48 object-cover" />
            <div class="p-6">
              <h3 class="text-xl font-bold text-[#000A2B] mb-2">{{ project.title }}</h3>
              <p class="text-slate-600 mb-4">{{ project.description }}</p>
              <div class="flex flex-wrap gap-2 mb-4">
                <span
                  v-for="(tech, i) in project.technologies"
                  :key="i"
                  class="bg-[#0FDBD0] bg-opacity-20 text-[#000A2B] px-3 py-1 rounded-full text-sm font-medium"
                >
                  {{ tech }}
                </span>
              </div>
              <button class="flex items-center gap-2 text-[#0FDBD0] hover:text-[#0ac5bb] font-semibold transition-colors">
                <RouterLink to="/qcm">  voir le projet</RouterLink>
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                </svg>
              </button>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Skills Section -->
    <section id="compétences" class="py-20 px-6 lg:px-12 bg-white">
      <div class="max-w-6xl mx-auto">
        <h2 class="text-4xl font-bold text-center text-[#000A2B] mb-12">Mes Compétences</h2>
        <div class="grid md:grid-cols-2 gap-6">
          <div
            v-for="(skill, index) in skills"
            :key="index"
            class="bg-gradient-to-br from-slate-50 to-slate-100 p-6 rounded-xl shadow-md"
          >
            <div class="flex items-center gap-3 mb-3">
              <span class="text-3xl">{{ skill.icon }}</span>
              <span class="font-bold text-[#000A2B] text-lg">{{ skill.name }}</span>
              <span class="ml-auto text-[#0FDBD0] font-bold">{{ skill.level }}%</span>
            </div>
            <div class="w-full bg-slate-200 rounded-full h-3 overflow-hidden">
              <div
                class="bg-gradient-to-r from-[#0FDBD0] to-[#0ac5bb] h-full rounded-full transition-all duration-1000 ease-out"
                :style="{ width: `${skill.level}%` }"
              ></div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="py-20 px-6 lg:px-12 bg-gradient-to-br from-[#000A2B] to-[#001a4d]">
      <div class="max-w-4xl mx-auto text-center">
        <h2 class="text-4xl font-bold text-white mb-6">Travaillons ensemble !</h2>
        <p class="text-xl text-slate-300 mb-8">
          Je suis toujours ouverte à de nouveaux projets et opportunités
        </p>
        <div class="flex justify-center gap-6 flex-wrap">
          <a
            v-for="social in socials"
            :key="social.name"
            :href="social.link"
            class="bg-white text-[#000A2B] p-4 rounded-full hover:bg-[#0FDBD0] transition-all duration-300 hover:scale-110 shadow-lg"
            :aria-label="social.name"
          >
            <component :is="social.icon" class="w-7 h-7" />
          </a>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="bg-[#000A2B] text-white py-8 px-6 text-center">
      <p class="text-slate-400">
        © {{ currentYear }} Marie Shalice. Développé avec tailwindcss et Vue.js
      </p>
    </footer>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';

// État réactif
const isMenuOpen = ref(false);
const activeSection = ref('accueil');

// Menu items
const menuItems = ['Accueil', 'À propos', 'Projets', 'Compétences', 'Contact'];

// About cards avec icônes SVG inline
const aboutCards = [
  {
    title: 'Développement',
    description: 'Création d\'applications web modernes et performantes avec Vue.js et les dernières technologies',
    icon: {
      template: `<svg fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4" /></svg>`
    }
  },
  {
    title: 'Design',
    description: 'Interfaces utilisateur élégantes et intuitives avec une attention particulière aux détails',
    icon: {
      template: `<svg fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01" /></svg>`
    }
  },
  {
    title: 'Innovation',
    description: 'Toujours à la recherche de nouvelles solutions et technologies pour créer des expériences uniques',
    icon: {
      template: `<svg fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" /></svg>`
    }
  }
];

// Projects data
const projects = [
  {
    title: 'E-commerce Platform',
    description: 'Application de commerce en ligne avec panier et paiement intégré',
    technologies: ['Vue.js', 'Tailwind', 'Node.js'],
    image: './../assets/image/Capture d’écran 2025-11-07 172421.png'
  },
  {
    title: 'Dashboard Analytics',
    description: 'Tableau de bord interactif pour la visualisation de données',
    technologies: ['Vue 3', 'Chart.js', 'Firebase'],
    image: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=600&h=400&fit=crop'
  },
  {
    title: 'Application Mobile',
    description: 'Application de gestion de tâches avec synchronisation cloud',
    technologies: ['Vue Native', 'Vuex', 'API REST'],
    image: 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=600&h=400&fit=crop'
  }
];

// Skills data
const skills = [
  { name: 'Vue.js', level: 90, icon: '⚡' },
  { name: 'Tailwind CSS', level: 85, icon: '🎨' },
  { name: 'JavaScript', level: 88, icon: '📜' },
  { name: 'Node.js', level: 75, icon: '🟢' },
  { name: 'Git', level: 80, icon: '🔧' },
  { name: 'REST API', level: 82, icon: '🔌' }
];

// Social links
const socials = [
  {
    name: 'Email',
    link: '#',
    icon: {
      template: `<svg fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" /></svg>`
    }
  },
  {
    name: 'GitHub',
    link: '#',
    icon: {
      template: `<svg fill="currentColor" viewBox="0 0 24 24"><path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/></svg>`
    }
  },
  {
    name: 'LinkedIn',
    link: '#',
    icon: {
      template: `<svg fill="currentColor" viewBox="0 0 24 24"><path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/></svg>`
    }
  }
];

// Computed
const currentYear = computed(() => new Date().getFullYear());

// Methods
const scrollToSection = (section) => {
  activeSection.value = section.toLowerCase();
  isMenuOpen.value = false;
  
  const element = document.getElementById(section.toLowerCase());
  if (element) {
    const headerOffset = 80;
    const elementPosition = element.getBoundingClientRect().top;
    const offsetPosition = elementPosition + window.pageYOffset - headerOffset;

    window.scrollTo({
      top: offsetPosition,
      behavior: 'smooth'
    });
  }
};
</script>

<style scoped>
@keyframes pulse-slow {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.8;
  }
}

.animate-pulse-slow {
  animation: pulse-slow 3s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}
</style>