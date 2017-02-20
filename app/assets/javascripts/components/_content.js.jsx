var Content = React.createClass({
  getInitialState() {
    return { solutions: [] }
  },
  
  componentDidMount() {
    $.getJSON('/api/v1/users/2/solutions', (response) => { this.setState({ solutions: response }) })
  },
  
  handleDelete(solution_id, id) {
    $.ajax({
      url: `/api/v1/solutions/${solution_id}/feedbacks/${id}`,
      type: 'PATCH',
      success(response) {
        console.log('changed status to read', response)
      }
    })
  },
  
  render(){
    var feedbacks = this.state.solutions.map((solution) => {
      var returnFeedbacks = 
      solution.feedbacks.map((feedback) => {
        return (
        <div key={feedback.id}>
          <li>
            <p>Unread feedback:</p>
            <p>{feedback.comment}</p>
            <button onClick={this.handleDelete.bind(this, feedback.solution_id, feedback.id)}>X</button>
          </li>
        </div>
        )
      });
      return returnFeedbacks
    });
    
    return(
      <div>
        { feedbacks }
      </div>
    )
  }
});