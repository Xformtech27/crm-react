package com.crm.service;

import com.crm.dto.request.ContactRequest;
import com.crm.entity.Contact;
import com.crm.exception.ResourceNotFoundException;
import com.crm.repository.ContactRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ContactService {

    private final ContactRepository contactRepository;

    public List<Contact> getAllContacts(Long userId, String role) {
        return contactRepository.findAll();
    }

    public Contact getById(Long id) {
        return contactRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Contact", "id", id));
    }

    public Contact create(ContactRequest req, Long userId) {
        return contactRepository.save(mapToEntity(req, new Contact()));
    }

    public Contact update(Long id, ContactRequest req) {
        Contact contact = getById(id);
        return contactRepository.save(mapToEntity(req, contact));
    }

    public void delete(Long id) {
        contactRepository.delete(getById(id));
    }

    private Contact mapToEntity(ContactRequest req, Contact contact) {
        contact.setContactName(req.getContactName());
        contact.setContactMobileNo(req.getContactMobileNo());
        contact.setContactEmail(req.getContactEmail());
        contact.setContactAddress(req.getContactAddress());
        contact.setContactCity(req.getContactCity());
        contact.setContactState(req.getContactState());
        contact.setContactCountry(req.getContactCountry());
        contact.setContactOccasion(req.getContactOccasion());
        contact.setContactPostalCode(req.getContactPostalCode());
        contact.setContactOccasionDate(req.getContactOccasionDate());
        return contact;
    }
}
