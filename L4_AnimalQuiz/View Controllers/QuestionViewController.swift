//
//  QuestionViewController.swift
//  L4_AnimalQuiz
//
//  Created by Vitaly Zubenko on 12.05.2022.
//

import UIKit

class QuestionViewController: UIViewController {
    // нам нужны элементы аутлеты которые будут на всех трех экранах
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var questionLable: UILabel!
    
    @IBOutlet var rangedSlider: UISlider! {
        didSet {
            let answersCountInIndexes = Float(questions[questionIndex].answers.count - 1)
            rangedSlider.maximumValue = answersCountInIndexes
        }
    }
    // didSet каждый раз реагирует на изменения этого слайдера
    // мы меняем значение и у нас что-то применяется
    
    // и дальше стеки
    // я так понимаю чтобы иметь возможность их скрывать и показывать
    @IBOutlet var singleAnswerStackView: UIStackView!
    @IBOutlet var multipleAnswersStackView: UIStackView!
    @IBOutlet var rangedAnswerStackView: UIStackView!
 
    // дальше нам надо добавить аутлеты для наших элементов
    // но кнопок несколько одинаковых, поэтому добавлять по одному элементу будет очень долго
    @IBOutlet var singleButtons: [UIButton]!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    @IBOutlet var rangedLabels: [UILabel]!
    
    // MARK: Properties
    private let questions = Question.getQuestion()
    private var questionIndex = 0
    // теперь нам надо каким то образом прихранивать те объекты который мы храним, чтобы потом как-то с ним работать, и выдавать результат теста на основе их. Приватнное свойство тоже
    private var answerChosen: [Answer] = [] // присвоим пустому списку сначала, чтобы было проще
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    // тут вызываем приватную updateUI (ниже) для отображения при загрузке приложения
    
    // MARK: Buttons pressed
    // теперь надо сделать экшнены для каждой кнопки наконец. Они нажимаются, но ничего ж не делают пока
    // поставим теперь type Button, потому что нам надо сейчас учитывать уже кто там нажал и это потом обработать
    // и остальные кнопки тоже законектить/перетащить в этот экшн. Нам пофиг на какую нажали, а уже это обработаем что происхоть будет
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        // сначала мы должны посмотреть индекс той кнопки которую нажали. Обязательно разввернем, потому что это будет у нас опционально
        guard let currentIndex = singleButtons.firstIndex(of: sender)
        else { return }
        
        // теперь узнаем чему у нас равен ответ у конкретного индекса
        let currentAnswer = currentAnswers[currentIndex]
        
        // и выбранный ответ мы добавляем в наш пока пустой массив ответов
        answerChosen.append(currentAnswer)
        
        nextQuestion()
    }
    
    // теперь сделаем экшн для кнопки из стека со свитчами вопроса
    // и мы не хотим ей ничего передавать, сендер ноун
    @IBAction func multipleAnswerButtonPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answerChosen.append(answer)
            }
        }
        
        nextQuestion()
    }

    @IBAction func rangedAnswerButtonPressed() {
        let index = Int(rangedSlider.value)
        answerChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
}

// MARK: Private methods
// для удобного разделения чтобы приватные методы хранились отдельно, дабы мы на них не обращали внимания
extension QuestionViewController {
    private func updateUI() {
        
        // hide stacks
        for stackView in [singleAnswerStackView, multipleAnswersStackView, rangedAnswerStackView] {
            stackView?.isHidden = true
        }
        
        // теперь нам нужны базовые переменные в которых мы будем хранить состояние и с помощью которых будем регулировать поведение
        // get current question
        let currentQuestion = questions[questionIndex]
        
        // теперь делаем лейбл равным вопросу
        // set current question for label
        questionLable.text = currentQuestion.text
        
        // carculate progress
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        // set progress for progressView
        progressView.setProgress(totalProgress, animated: true)
        
        // менять текст Вопрос и номер
        // тайтл переменная у нас уже есть автоматические. Это тайтл нашего вью контролера
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        // show current Stack View
        // вот теперь уже можем вызвать текущ стеквью
        // надо показать сейчас сингл квешчины в for, но мы поступим умнее чтобы использовать и другие вопросы потом
        showCurrentStackView(for: currentQuestion.type)
    }
    
    // используем созданный enum
    private func showCurrentStackView(for type: ResponseType) {
        switch type {
        case .single:
            showSingleStackView(with: currentAnswers)
        case .multiple:
            showMultipleStackView(with: currentAnswers)
        case .range:
            showRangedStackView(with: currentAnswers)
        }
    }
    
    private func showSingleStackView(with answers: [Answer]) {
        singleAnswerStackView.isHidden = false
        
        // теперь мы хотим чтобы в каждой кнопочке у нас был вариант ответа из нашего опроса. В нашем стеке. Нам пришли ответы, теперь нам надо их отобразить
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.text, for: .normal)
            
            // и мы хотим пройтись по двум арреям (спискам). Ансверам и Кнопкам. И чтобы не делать один for внутри другого, есть zip. Тоесть мы сделали шаг в баттонах, мы хотим сделать шаг в ансверах, чтобы смотреть как соответствует баттон к ансверу.
        }
    }
    
    private func showMultipleStackView(with answers: [Answer]) {
        multipleAnswersStackView.isHidden = false
        
        for (lable, answer) in zip(multipleLabels, answers) {
            lable.text = answer.text
        }
    }
    
    private func showRangedStackView(with answers: [Answer]) {
        rangedAnswerStackView.isHidden = false
        
        rangedLabels.first?.text = answers.first?.text
        rangedLabels.last?.text = answers.last?.text
        // мы их и так задали в сториборде, но все равно на всякий случай проставить
        // вдруг нам эти варианты будут приходить с сервера
    }
    
    // приватный метод переключения вопросов.
    // не будем это пилить в сам код, а вынесем в отдельный метод который будет знать как это работает
    private func nextQuestion() {
        questionIndex += 1
        
        // и мы должны остановиться на последнем. Тоесть мы ограничены индексом 2
        if questionIndex < questions.count {
            updateUI()
            return
        }
                
        performSegue(withIdentifier: "showResult", sender: nil)
    }
    // и добавляем ее в экшн сингл баттона и другие
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showSegue" else { return }
        guard let destination = segue.destination as? FinalViewController else { return }
        destination.answers = answerChosen
    }
}
