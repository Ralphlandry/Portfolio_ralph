<template>
  <RouterView/>
  <div class="flex gap-4 justify-arround center  " :aria-busy="state === 'loading'">
    <div>
      <Quiz :quiz="quiz" v-if="quiz" />
    </div>
  </div>  
</template>

<script setup>
import { ref } from 'vue'
import { onMounted } from 'vue'
import Quiz from '@/componments/Quiz.vue' // Assure-toi que le chemin est correct

const quiz = ref(null)
const state = ref('loading')

onMounted(() => {
  fetch('/quiz.json') // Assure-toi que le fichier est bien dans le dossier public
    .then(r => {
      if (r.ok) return r.json()
      throw new Error('Erreur de chargement')
    })
    .then(data => {
      quiz.value = data
    })
    .catch(err => {
      console.error(err)
    })
})
</script>
