package com.melanin.security

import org.apache.commons.lang.builder.HashCodeBuilder
import grails.gorm.DetachedCriteria
import groovy.transform.ToString

import org.codehaus.groovy.util.HashCodeHelper

@ToString(cache=true, includeNames=true, includePackage=false)
class UserRole implements Serializable {
	private static final long serialVersionUID = 1

	User user
	Role role

	@Override
	boolean equals(other) {
		if (other instanceof UserRole) {
			other.userId == user?.id && other.roleId == role?.id
		}
	}

	/*boolean equals(other) {
		if (!(other instanceof UserRole)) {
			return false
		}

		other.user?.id == user?.id &&
			other.role?.id == role?.id
	}*/
	@Override
	int hashCode() {
		int hashCode = HashCodeHelper.initHash()
		if (user) {
			hashCode = HashCodeHelper.updateHash(hashCode, user.id)
		}
		if (role) {
			hashCode = HashCodeHelper.updateHash(hashCode, role.id)
		}
		hashCode
	}

	/*
	int hashCode() {
		def builder = new HashCodeBuilder()
		if (user) builder.append(user.id)
		if (role) builder.append(role.id)
		builder.toHashCode()
	}*/

	static UserRole get(long userId, long roleId) {
		find 'from UserRole where user.id=:userId and role.id=:roleId',
			[userId: userId, roleId: roleId]
	}

	static UserRole create(User user, Role role, boolean flush = false) {
		new UserRole(user: user, role: role).save(flush: flush, insert: true)
	}

	static boolean remove(User user, Role role, boolean flush = false) {
		UserRole instance = UserRole.findByUserAndRole(user, role)
		if (!instance) {
			return false
		}

		instance.delete()
		true
	}

	static void removeAll(User user) {
		executeUpdate 'DELETE FROM UserRole WHERE user=:user', [user: user]
	}

	static void removeAll(Role role) {
		executeUpdate 'DELETE FROM UserRole WHERE role=:role', [role: role]
	}

	/*static constraints = {
		role validator: { Role r, UserRole ur ->
			if (ur.user?.id) {
				UserRole.withNewSession {
					if (UserRole.exists(ur.user.id, r.id)) {
						return ['userRole.exists']
					}
				}
			}
		}
	}*/

	static mapping = {
		id composite: ['role', 'user']
		version false
	}
}
