public class Bag {

    private Long amount;
    private Invitation invitation;
    private Ticket ticket;

    // 초대장을 받지 않은 관람객의 가방
    public Bag(Long amount) {
        this(null, amount);
    }

    // 초대장을 받은 관람객의 가방
    public Bag(Invitation invitation, Long amount) {
        this.invitation = invitation;
        this.amount = amount;
    }

    public Long hold(Ticket ticket) {
        if(hasInvitation()) {
            setTicket(ticket);
            return 0L;
        } else {
            setTicket(ticket);
            minusAmount(ticket.getFee());
            return ticket.getFee();
        }
    }

    private boolean hasInvitation() {
        return invitation != null;
    }

    public boolean hasTicket() {
        return ticket != null;
    }

    private void setTicket(Ticket ticket) {
        this.ticket = ticket;
    }

    public void setInvitation(Invitation invitation) {
        this.invitation = invitation;
    }

    private void plusAmount(Long amount) {
        this.amount += amount;
    }

    private void minusAmount(Long amount) {
        this.amount -= amount;
    }

}
