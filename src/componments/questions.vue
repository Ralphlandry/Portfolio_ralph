<template>
  <!-- Conteneur principal avec style Tailwind -->
  <div class="flex flex-col question p-5 w-fit h-fit mt-8 shadow-xl rounded text-pink-600">
    
    <!-- Affiche le texte de la question -->
    <h3>{{ question.question }}</h3>

    <!-- Zone des choix de réponse -->
    <div class="text-black flex justify-center gap-0.5 items-center">
      <ul>
        <!-- Boucle sur chaque choix de la question -->
        <li v-for="(choice, index) in question.choices" :key="index">
          
          <!-- Label lié à l'input radio -->
          <label :for="'answer' + index">
            
            <!-- Bouton radio pour chaque choix -->
            <input
              :id="'answer' + index"       
              type="radio"                 
              name="answer"            
              :value="choice"             
              v-model="selectedAnswer"     

            />
             <!-- // ID unique pour chaque bouton  -->
            <!-- Type radio = sélection unique -->
                <!-- Groupe de boutons -->
             <!-- Valeur du bouton -->
            <!-- Liaison avec la variable sélectionnée -->
            {{ choice }}                   <!-- Affiche le texte du choix -->
          </label>
        </li>
      </ul>
    </div>

    <!-- Bouton pour valider la réponse -->
      <!-- Envoie la réponse au parent -->
       <!-- Désactivé si aucune réponse n'est sélectionnée -->
    <div>
      <button
        :disabled="!hasAnswer"            
        @click="emitAnswer"             
        class="flex ml-[300px] p-2 shadow-xl rounded-[5px] text-black bg-pink-500"
      >
        Question suivante
      </button>
    </div>
  </div>
</template>

<script setup>
/* Import des fonctions réactives de Vue */
import { ref, computed } from 'vue'

/* Déclaration des props reçues du parent */
const props = defineProps({
  question: {
    type: Object,       // La prop doit être un objet
    required: true      // Elle est obligatoire
  }
})

/* Déclaration des événements que le composant peut émettre */
const emit = defineEmits(['answer'])

/* Variable réactive pour stocker la réponse sélectionnée */
const selectedAnswer = ref(null)

/* Propriété calculée : devient true si une réponse est sélectionnée */
const hasAnswer = computed(() => selectedAnswer.value !== null)

/* Fonction appelée au clic sur le bouton : envoie la réponse au parent */
const emitAnswer = () => {
  emit('answer', selectedAnswer.value)
}
</script>
