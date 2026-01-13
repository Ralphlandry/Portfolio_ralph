<template>

  <div class="flex flex-col justify-center items-center gap-4">

    <!-- Titre du quiz -->
    <div class="flex gap-3 justify-center items-center my-7 w-screen">

      <div class="flex ml-[1px] animate-bounce">
        <!-- Icône -->
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
          class="size-8">
          <path stroke-linecap="round" stroke-linejoin="round"
            d="M4.26 10.147a60.438 60.438 0 0 0-.491 6.347A48.62 48.62 0 0 1 12 20.904a48.62 48.62 0 0 1 8.232-4.41 60.46 60.46 0 0 0-.491-6.347m-15.482 0a50.636 50.636 0 0 0-2.658-.813A59.906 59.906 0 0 1 12 3.493a59.903 59.903 0 0 1 10.399 5.84c-.896.248-1.783.52-2.658.814m-15.482 0A50.717 50.717 0 0 1 12 13.489a50.702 50.702 0 0 1 7.74-3.342M6.75 15a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Zm0 0v-3.675A55.378 55.378 0 0 1 12 8.443m-7.007 11.55A5.981 5.981 0 0 0 6.75 15.75v-1.5" />
        </svg>
      </div>

      <div>
        <h1 class="text-3xl font-bold text-pink-700 animate-bounce ">{{ quiz.title }}</h1>
      </div>

    </div>

    <div class="flex">
      <!-- Corps du quiz -->

      <div class="flex flex-col gap-7">
        <!-- Barre de progression -->
        <div v-if="quiz.questions && quiz.questions.length">
          <Progress :value="step" :max="quiz.questions.length - 1" />
        </div>

        <!-- Affichage des questions -->
        <div v-if="state === 'question' && question">
          <Question :question="question" @answer="addAnswer" />
        </div>

        <!-- Résumé des réponses -->
        <div v-else-if="state === 'recap'" class="text-center">
          <h2 class="text-xl font-semibold text-green-600">Résultats</h2>
          <p class="my-4">
            {{ score >= quiz.minimun_score ? quiz.success_message : quiz.failure_message }}
          </p>

          <ul class="text-left space-y-4">
            <li v-for="(response, index) in answers" :key="index">
              <strong>Q{{ index + 1 }}:</strong> {{ quiz.questions[index].question }}<br />
              <span class="text-pink-600">Votre réponse :</span> {{ response }}<br />
              <span class="text-green-600">Bonne réponse :</span> {{ quiz.questions[index].correct_answer }}
            </li>
          </ul>

        </div>
      </div>     

    </div>
  </div>

</template>


<script setup>
import { computed, ref } from 'vue'
import Progress from './progress.vue'
import Question from './questions.vue'

// Props
const props = defineProps({
  quiz: Object
})

// État du quiz
const state = ref('question')
const step = ref(0)

// Réponses de l'utilisateur
const answers = ref(props.quiz?.questions?.map(() => null) ?? [])

// Question actuelle
const question = computed(() => {
  return props.quiz?.questions?.[step.value] ?? null
})

// Ajout d'une réponse
const addAnswer = (answer) => {
  answers.value[step.value] = answer

  if (step.value >= props.quiz.questions.length - 1) {
    state.value = 'recap'
  } else {
    step.value++
  }
}

// Calcul du score
const score = computed(() => {
  return answers.value.reduce((total, response, index) => {
    return response === props.quiz.questions[index].correct_answer ? total + 1 : total
  }, 0)
})
</script>
